{
  description = "Constructive Logic and Formal Proof High-school Course";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";

    mdx_truly_sane_lists.url = "github:xhalo32/mdx_truly_sane_lists"; # Supports 0-indexing!
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.devenv.flakeModule ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        let
          lib = pkgs.lib;
          pythonOverrides = [
            (final: prev: {
              mdx-truly-sane-lists = inputs.mdx_truly_sane_lists.outputs.packages.${system}.default;
            })
          ];
          python = pkgs.python3.override { packageOverrides = lib.composeManyExtensions pythonOverrides; };
          mkdocs-env = python.withPackages (
            ps: with ps; [
              mkdocs-material
              mkdocs-git-revision-date-localized-plugin
              mdx-truly-sane-lists
            ]
          );
        in
        {
          # Per-system attributes can be defined here. The self' and inputs'
          # module parameters provide easy access to attributes of the same
          # system.

          packages.serve = pkgs.writeShellApplication {
            name = "serve";
            runtimeInputs = with pkgs; [
              mkdocs
              mkdocs-env
            ];
            text = ''
              mkdocs serve
            '';
          };

          # Bonked from https://galowicz.de/2023/02/20/simple-documentation-with-mkdocs-plantuml-c4-integration/
          packages.html = pkgs.stdenv.mkDerivation {
            name = "mkdocs-html";

            # allow-list filter for what we need: No readmes, nix files, source code
            # of the project, etc... --> this avoids unnecessary rebuilds
            src = lib.sourceByRegex ./. [
              "^docs.*"
              "mkdocs.yml"
            ];

            nativeBuildInputs = with pkgs; [
              mkdocs
              mkdocs-env
            ];

            buildPhase = ''
              mkdocs build --strict -d $out
            '';

            # This derivation does no source code compilation or testing
            dontConfigure = true;
            doCheck = false;
            dontInstall = true;
          };

          packages.default = self'.packages.serve;

          devenv.shells.default = {
            packages = with pkgs; [
              git
              mkdocs
              mkdocs-env
            ];
          };
        };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.
      };
    };
}
