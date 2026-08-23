{
  description = "Personal package set";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hunk.url = "github:modem-dev/hunk";
    hunk.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, hunk }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      # Releases: https://github.com/astral-sh/uv/releases
      # To bump, set version below and take the hash from:
      #   nix store prefetch-file --json https://github.com/astral-sh/uv/releases/download/<VER>/uv-x86_64-unknown-linux-gnu.tar.gz
      uv = pkgs.stdenv.mkDerivation rec {
        pname = "uv";
        version = "0.12.5";

        src = pkgs.fetchurl {
          url = "https://github.com/astral-sh/uv/releases/download/${version}/uv-x86_64-unknown-linux-gnu.tar.gz";
          hash = "sha256-aKUJ2iSwa0IjocAXX7XrW8eTQrdsvv8M/lGsP1sXtrI=";
        };

        nativeBuildInputs = [ pkgs.autoPatchelfHook ];
        buildInputs = [ pkgs.stdenv.cc.cc.lib ];

        installPhase = ''
          runHook preInstall
          install -Dm755 uv uvx -t $out/bin
          runHook postInstall
        '';
      };
    in {
      packages.${system}.default = pkgs.buildEnv {
        name = "my-packages";
        paths = with pkgs; [
          neovim
          ripgrep
          fd
          fzf
          terraform
        ] ++ [
          hunk.packages.${system}.default
        ];
      };
    };
}
