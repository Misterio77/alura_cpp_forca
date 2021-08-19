{
  description = "Joguinho de forca";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      name = "forca";
    in rec {

      packages.${name} = pkgs.stdenv.mkDerivation {
        pname = name;
        version = "1.1";
        src = ./.;
        installPhase = ''
          mkdir -p $out/bin
          mv build/${name} $out/bin
        '';
      };
      defaultPackage = packages.${name};

      apps.${name} = {
        type = "app";
        program = "${packages.${name}}/bin/${name}";
      };
      defaultApp = apps.${name};

      devShell =
        pkgs.mkShell { buildInputs = with pkgs; [ gnumake gcc valgrind gdb ]; };
    });
}
