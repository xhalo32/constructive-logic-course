# TODO create utilities

let
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

in {
  
}