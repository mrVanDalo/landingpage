# Landingpage

Is a simple html file using js and json to create a single html file for links, 
which are important for your company/team.
So it can be shared across teams via git and put as first page to load (instead of google).

Feel free to edit everything

# Import using flakes

``` nix
{

   description = "macOS configuration";

   inputs = {
     nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
     home-manager = {
       url = "github:nix-community/home-manager/release-21.05";
       inputs.nixpkgs.follows = "nixpkgs";
     };
    landingpage = {
       url = "github:mrVanDalo/landingpage";
       inputs.nixpkgs.follows = "nixpkgs";
     };
   };
   
   
   outputs = { self, nixpkgs, home-manager, landingpage, ... }:
    let
      nixosSystem = nixpkgs.lib.nixosSystem;
    in {
      
      # us it in you nixosConfiguration
      nixosConfigurations.example = nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModule 
          { home-manager.users.exampleUser.imports = [ landingpage.hmModule."x86_64-linux" ]; }
        ];
      };
      
      # or use it as homeManagerConfiguration 
      homeManagerConfigurations = {
        darwin = home-manager.lib.homeManagerConfiguration {
          configuration = ./home.nix;
          extraModules = [ landingpage.hmModule."x86_64-darwin" ];
          system = "x86_64-darwin";
          homeDirectory = "/Users/mrvandalo";
          username = "mrvandalo";
        };
      };
    };
   
}
```

