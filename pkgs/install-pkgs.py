#!/usr/bin/env python3
"""Install Debian packages from a TOML manifest, configuring repos as needed."""

import os
import subprocess
import sys
import tomllib
from pathlib import Path

KEYRING_DIR = Path("/etc/apt/keyrings")
SOURCES_DIR = Path("/etc/apt/sources.list.d")
ENV = {**os.environ, "DEBIAN_FRONTEND": "noninteractive"}


def run(*args):
    subprocess.run(args, check=True, env=ENV)


def apt_install(packages, target=None):
    cmd = ["apt-get", "install", "-y", "--no-install-recommends"]
    if target:
        cmd += ["-t", target]
    run(*cmd, *packages)


def repo_configured(name, key_url, source):
    if source and not (SOURCES_DIR / f"{name}.list").exists():
        return False
    if key_url and not any(
        (KEYRING_DIR / f"{name}.{ext}").exists() for ext in ("asc", "gpg")
    ):
        return False
    return True


def setup_repo(name, key_url, source):
    """Fetch the GPG key and write the sources.list entry for one repo."""
    keyring = ""
    if key_url:
        KEYRING_DIR.mkdir(parents=True, exist_ok=True)
        data = subprocess.run(
            ["curl", "-fsSL", key_url], check=True, capture_output=True
        ).stdout
        armored = b"BEGIN PGP" in data[:200]
        path = KEYRING_DIR / f"{name}.{'asc' if armored else 'gpg'}"
        path.write_bytes(data)
        path.chmod(0o644)
        keyring = str(path)
    if source:
        SOURCES_DIR.mkdir(parents=True, exist_ok=True)
        entry = source.replace("%KEYRING%", keyring)
        (SOURCES_DIR / f"{name}.list").write_text(entry + "\n")


def main():
    if os.geteuid() != 0:
        sys.exit(f"Run with sudo: sudo {sys.argv[0]}")

    manifest_path = Path(sys.argv[1] if len(sys.argv) > 1 else "packages.toml")
    with manifest_path.open("rb") as f:
        manifest = tomllib.load(f)

    to_setup = []
    for name, sec in manifest.items():
        key_url, source = sec.get("key", ""), sec.get("source", "")
        if not (key_url or source):
            continue
        if repo_configured(name, key_url, source):
            print(f"Repo already configured, skipping: {name}")
            continue
        to_setup.append((name, key_url, source))

    if any(key_url for _, key_url, _ in to_setup):
        run("apt-get", "update")
        apt_install(["curl", "ca-certificates"])

    for name, key_url, source in to_setup:
        print(f"Configuring repo: {name}")
        setup_repo(name, key_url, source)

    run("apt-get", "update")

    total = 0
    for name, sec in manifest.items():
        packages = sec.get("packages", [])
        if not packages:
            continue
        target = sec.get("target")
        suffix = f" (target: {target})" if target else ""
        print(f"Installing {len(packages)} packages from [{name}]{suffix}")
        apt_install(packages, target)
        total += len(packages)

    run("apt-get", "autoremove", "-y")
    print(f"Done: installed {total} packages across {len(manifest)} sections.")


if __name__ == "__main__":
    main()
