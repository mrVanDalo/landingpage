
A simple HTML file using JSON to create a list of links.
This is useful to collect links for projects or the teams you are working in.

![](./img/screenshot.png)

## structure

You define everything via JSON (or nix if you use the nix module).

```json
{
  "title": "title",
  "text": "text",
  "items" : [
    {
      "label": "go to example.com",
      "href": "https://example.com",
      "image": "https://media.giphy.com/media/xrrvZiFNuK7Xa/giphy.gif"
    },
    {
      "label": "go to other example.com",
      "href": "https://other-example.com",
      "image": "https://media.giphy.com/media/xrrvZiFNuK7Xa/giphy.gif"
    }
  ]
}
```

## Nixpkgs

Provides nixpkgs which can be overwritten

``` nix
services.nginx.virtualHosts."example.org" = {
  locations."/" = {
    root = pkgs.landingpage.override { 
      jsonConfig = [{
        title = "title";
        text = "text";
        items = [
          {
            label = "go to example.com";
            href = "https://example.com";
            image = "https://media.giphy.com/media/xrrvZiFNuK7Xa/giphy.gif;
          }
          {
            label = "go to example.com";
            href = "https://example.com";
            image = "https://media.giphy.com/media/xrrvZiFNuK7Xa/giphy.gif;
          }
        ];
      }];
    };
  };
};
```

### parameter to override

- title: "browser tab title
- max-width:  width of the content block
- background-color: background color of the whole page
- title-color: color of the title block
- title-background-color: background color of the title block
- text-color: text color of the text block
- text-background-color: background color of the text block
- item-color: text color of the items
- item-background-color: background color of the items
- image-width: width of the images
- image-height: height of the images
- jsonConfig: the content defined under structure