{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      ref = "28029c9203d54f4fc9332d094927cd82154331f2";
    in
    {
      packages = rec {
        bgrep = pkgs.stdenv.mkDerivation rec {
          pname = "bgrep";
          version = "master";  # new version hasn't been released since 2011
          src = pkgs.fetchFromGitHub {
              owner = "tmbinc";
              repo = "bgrep";
              rev = ref;
              hash = "sha256-gAtxAJ1z9mXViEyQ0WedjuBDg5jqUvAS51axbx3SOGM=";
          };

          installFlags = [ "install_dir=$(out)" ];
        };
        default = bgrep;
      };
    }
  );
}
