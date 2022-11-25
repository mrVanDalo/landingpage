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
        <title>${title}</title>
        <!-- The font -->
        <link href="https://fonts.googleapis.com/css?family=Dosis&display=swap" rel="stylesheet">
      <style> ${lib.fileContents ./plain.css} </style>
      </head>
      <body>

    ${let

      createItemContainer = list:
        with lib;
        let
          a = optionalString
            (list != [])
            ''<div class="a">${createSubItem (head list)}</div>'';
          bList = drop 1 (take 2 list);
          b = optionalString
            (bList != [])
            ''<div class="b">${createSubItem (head bList)}</div>'';
          rest = drop 2 list;
          in
        if list == []
        then []
        else
          concat [''<div class="item-container"> ${a} ${b} </div>''] (createItemContainer rest);

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
            ${concatStringsSep "\n" (createItemContainer items)}
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
