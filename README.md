
A simple HTML file using JSON to create a list of links.
This is useful to collect links for projects or the teams you are working in.

![](./img/screenshot.png)

## structure

![](./img/structure.png)

You define everything via JSON (or nix if you use the nix module).

```
title : "title",
text : "text",
items = [
  {
    "label": "go to example.com";
    "href": "https://example.com";
    "image": "https://media.giphy.com/media/xrrvZiFNuK7Xa/giphy.gif";
  }
]
```

# Nixpkgs

Provides nixpkgs which can be overwritten

``` nix
services.nginx.virtualHosts."example.org" = {
  locations."/" = {
    root = pkgs.landingpage.override { jsonConfig.items = [...]; };
  };
};
```

# Using via Homemanager and flakes

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

