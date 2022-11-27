{
  description = "landingpage";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          packages.plain = pkgs.callPackage ./pkgs/landingpage/plain.nix { };
          packages.default = self.packages.${system}.plain;

          # nix build
          defaultPackage = self.packages.${system}.plain;

          apps.default = self.apps.${system}.createNonNix;
          apps.createNonNix = {
            type = "app";
            program =
              let
                pkg = self.packages.${system}.plain;
              in
              toString (pkgs.writeShellScript "create-non-nix" ''
                set -e
                cp ${pkg}/index.html docs/index.html
              '');
          };

        }
      );
}
