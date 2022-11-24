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
      <style>
        :root{
          font-family: 'Dosis', sans-serif;
        }
          body {
            margin-left:0px;
            margin-right:0px;
            padding-left:0px;
            padding-right:0px;
          }
          .container {
            margin-left:0px;
            margin-right:0px;
            padding-left:0px;
            padding-right:0px;
          }
          .row-items {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
          }
          .row-title{
            text-align: center;
            padding-top: 7px;
            padding-bottom: 2px;
          }
          .row-text {
            text-align: center;
            background-color: #e6ffcc;
            padding-top: 7px;
            padding-bottom: 7px;
          }
          .item {
            display: grid;
            grid-template-columns: 250px;
            grid-template-rows: auto;
            grid-template-areas:
              "image"
              "text";
            margin: 2px;
            // border-style: solid;
            border-width: 0px;
            border-color:  #ffe6b3;
            background-color: #ffe6b3;
          }
          .item-image {
            grid-area: image;
            width: 250px;
            height: 180px;
          }
          .item-caption{
            grid-area: text;
            padding-bottom: 3px;
          };
          a {
            text-decoration: none;
            color: black;
          }
          a:link {
            text-decoration: none;
            color: black;
          }
          a:visited {
            text-decoration: none;
            color: black;
          }
          a:hover {
            text-decoration: none;
            color: black;
          }
          a:active {
            text-decoration: none;
            color: black;
          }
      </style>
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
