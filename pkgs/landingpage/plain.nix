{ lib
, writeTextFile
, jsonConfig ? [{
    text = "Landing Page Example";
    items = [
      {
        href = "https://nixos.org/";
        label = "NixOS";
        image = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
      }
      {
        href = "https://nixos.org/";
        label = "NixOS";
        image = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
      }
      {
        href = "https://nixos.org/";
        label = "NixOS";
        image = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
      }
    ];
  }
    {
      text = "NixOS";
      items = [
        {
          label = "NixOS Manual";
          href = "https://nixos.org/nixos/manual/";
          image =
            "https://media.giphy.com/media/dsdVyKkSqccEzoPufX/giphy.gif";
        }
        {
          label = "Nixpkgs Manual";
          href = "https://nixos.org/nixpkgs/manual/";
          image =
            "https://media.giphy.com/media/dsdVyKkSqccEzoPufX/giphy.gif";
        }
        {
          label = "NixOS Reference";
          href =
            "https://storage.googleapis.com/files.tazj.in/nixdoc/manual.html#sec-functions-library";
          image =
            "https://media.giphy.com/media/LkjlH3rVETgsg/giphy.gif";
        }
        {
          label = "Nix Packages";
          href = "https://nixos.org/nixos/packages.html";
          image =
            "https://media.giphy.com/media/l2YWlohvjPnsvkdEc/giphy.gif";
        }
        {
          label = "NixOS Language specific helpers";
          href =
            "https://nixos.wiki/wiki/Language-specific_package_helpers";
          image =
            "https://media.giphy.com/media/LkjlH3rVETgsg/giphy.gif";
        }
        {
          label = "NixOS Weekly";
          href = "https://weekly.nixos.org/";
          image =
            "https://media.giphy.com/media/lXiRLb0xFzmreM8k8/giphy.gif";
        }
        {
          label = "NixOS Security";
          href = "https://broken.sh/";
          image =
            "https://media.giphy.com/media/BqILAHjH1Ttm0/giphy.gif";
        }
        {
          label = "NixOS RFCs";
          href = "https://github.com/NixOS/rfcs/";
          image =
            "https://media.giphy.com/media/Uq9bGjGKg08M0/giphy.gif";
        }
      ];
    }]
, title ? "Landing Page"
, destination ? "/index.html"
, ...
}:

with lib;

writeTextFile {
  name = "landingpage";
  destination = destination;
  text = ''
    <!doctype html>
    <html>
      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, minimum-scale=1">
        <title>${title}</title>
        <!-- The font -->
        <link href="https://fonts.googleapis.com/css?family=Dosis&display=swap" rel="stylesheet">
      <style> ${lib.fileContents ./plain.css} </style>
      </head>
      <body>

    ${let

      createItemRow = { titel ? null, text ? null, items ? [ ] }: ''
        <div class="row">
          ${
            optionalString (titel != null)
            ''<h2 class="row-title">${title}</h2>''
          }
          ${
            optionalString (text != null) ''
              <div class="row-text">
                <pre>${text}</pre>
              </div>''
          }
          <div class="row-items">
            ${concatStringsSep "\n" (map createSubItem items)}
          </div>
        </div>'';

      createSubItem = { label, href, image }:
        # const shortLabel = (label.length > 28) ? `''${label.substring(0,25)}...` : label;

        ''
          <div class="item">
            <a target="_blank" rel="noopener noreferrer" href="${href}" class="thumbnail">
              <img src="${image}" class="item-image">
              <div class="item-caption" style="text-align:center;font-weight:bold">
                ${label}
              </div>
            </a>
          </div>'';

    in concatStringsSep "\n" (map createItemRow jsonConfig)}

      </body>
    </html>
  '';
}
