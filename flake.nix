{
  description = "Constructive Logic and Formal Proof High-school Course";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";

    mdx_truly_sane_lists.url = "github:xhalo32/mdx_truly_sane_lists"; # Supports 0-indexing!
    typix = {
      url = "github:xhalo32/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    typst-packages = {
    url = "github:typst/packages";
    flake = false;
  };
    niklashh-typst-packages = {
    url = "gitlab:niklashh/typst-packages";
  };
  };

  outputs =
    inputs@{ flake-parts, typix, ... }:
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
          FONTCONFIG_FILE = pkgs.makeFontsConf {
            fontDirectories = with pkgs; [
              lmodern
              fira
            ];
          };
          typixLib = typix.lib.${system};

          src = ./.;
          commonArgs = typstSource: {
            inherit typstSource;

            fontPaths = [
              # Add paths to fonts here
              "${pkgs.fira}/share/fonts/opentype"
            ];

            XDG_CACHE_HOME = typstPackagesCache;
          };

    typstPackagesSrc = pkgs.symlinkJoin {
    name = "typst-packages-src";
    paths = [
      "${inputs.typst-packages}/packages"
      inputs.niklashh-typst-packages.packages.${system}.default
    ];
  };

        typstPackagesCache = pkgs.stdenv.mkDerivation {
          name = "typst-packages-cache";
          src = typstPackagesSrc;
          dontBuild = true;
          installPhase = ''
            mkdir -p "$out/typst/packages"
            cp -LR --reflink=auto --no-preserve=mode -t "$out/typst/packages" "$src"/*
          '';
        };

          build-drv-palaveri-2024-07-12 = typixLib.buildTypstProject (commonArgs "slides/palaveri-2024-07-12.typ" // { inherit src; });
          build-script-palaveri-2024-07-12 = typixLib.buildTypstProjectLocal (commonArgs "slides/palaveri-2024-07-12.typ" // { inherit src; });
          watch-script-palaveri-2024-07-12 = typixLib.watchTypstProject (commonArgs "slides/palaveri-2024-07-12.typ");

          build-drv-muistiinpanot-2024-07-12 = typixLib.buildTypstProject (commonArgs "notes/muistiinpanot-2024-07-12.typ" // { inherit src; });
          build-script-muistiinpanot-2024-07-12 = typixLib.buildTypstProjectLocal (commonArgs "notes/muistiinpanot-2024-07-12.typ" // { inherit src; });
          watch-script-muistiinpanot-2024-07-12 = typixLib.watchTypstProject (commonArgs "notes/muistiinpanot-2024-07-12.typ");
        in
        {
          # Per-system attributes can be defined here. The self' and inputs'
          # module parameters provide easy access to attributes of the same
          # system.
# checks = {
#             inherit build-drv build-script watch-script;
#           };

          packages = {
            inherit build-drv-palaveri-2024-07-12 build-script-palaveri-2024-07-12 watch-script-palaveri-2024-07-12;
            inherit build-drv-muistiinpanot-2024-07-12 build-script-muistiinpanot-2024-07-12 watch-script-muistiinpanot-2024-07-12;
          };

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

          devenv.shells.default = {
            env.FONTCONFIG_FILE = FONTCONFIG_FILE;
            # env.XDG_CACHE_HOME = typstPackagesCache; # NOTE breaks everything
            packages = with pkgs; [
              mkdocs
              mkdocs-env
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
