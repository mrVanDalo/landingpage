{
  description = "landingpage";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.treefmt-nix.flakeModule
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { pkgs, self', ... }:
        {
          packages.plain = pkgs.callPackage ./pkgs/landingpage/plain.nix { };
          packages.default = self'.packages.plain;

          apps.createNonNix = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "create-non-nix" ''
                set -e
                cp ${self'.packages.plain}/index.html docs/index.html
              ''
            );
          };
          apps.default = self'.apps.createNonNix;

          treefmt = {
            projectRootFile = "flake.nix";
            programs.nixfmt.enable = true;
            programs.prettier.enable = true;
          };
        };
    };
}
