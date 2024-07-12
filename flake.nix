{
  description = "Constructive Logic and Formal Proof High-school Course";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
    lean4.url = "github:leanprover/lean4/d984030c6a683a80313917b6fd3e77abdf497809";

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
          autobuild = pkgs.writeShellScriptBin "autobuild" ''
            ${pkgs.inotify-tools}/bin/inotifywait -q -e close_write,moved_to,create -r -m ./Game.lean -m ./Game/ |
              while read -r directory events filename; do
                ${pkgs.elan}/bin/lake build
              done
          '';
          FONTCONFIG_FILE = pkgs.makeFontsConf {
            fontDirectories = with pkgs; [
              lmodern
              fira
            ];
          };
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

          packages.default = pkgs.stdenv.mkDerivation {
            name = "constructive-logic-course";
            src = ./.;
            buildPhase = ''
              cp -r . $out
              mkdir -p $out/bin
              echo 'cd ''$(dirname "''$(realpath $0)")/.. && ${mkdocs-env}/bin/.mkdocs-wrapped serve' > $out/bin/constructive-logic-course
              chmod +x $out/bin/constructive-logic-course
            '';
          };

          packages.autobuild = autobuild;

          devenv.shells.default = {
            env.FONTCONFIG_FILE = FONTCONFIG_FILE;
            packages = with pkgs; [
              mkdocs
              mkdocs-env
              texlive.combined.scheme-medium
              autobuild
              # inputs'.lean4.packages.lean
              elan
              typst
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
