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
          packages.masonry = pkgs.callPackage ./pkgs/landingpage/masonry.nix { };
          # nix build
          defaultPackage = self.packages.${system}.masonry;

          # home manager modules
          hmModules.landingpage = import ./module/default.nix { landingpage = self.defaultPackage.${system}; };
          hmModule.imports = [ self.hmModules.${system}.landingpage ];

        }
      )
  ;
}
