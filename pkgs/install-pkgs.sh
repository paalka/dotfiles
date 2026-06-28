#!/usr/bin/env sh
set -eu

# Thin entry point: ensure python3 exists, then hand off to install-pkgs.py.
if [ "$(id -u)" -ne 0 ]; then
  echo "Run with sudo: sudo $0" >&2
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 not found; installing it..."
  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get install -y --no-install-recommends python3
fi

exec python3 "$(dirname "$0")/install-pkgs.py" "$@"
