{ lib
, writeTextFile
, jsonConfig ? [{
    text = "Landing Page (Masonry)";
    items = [
      {
        url = "https://nixos.org/";
        label = "NixOS";
        image = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
      }
    ];
  }]
, title ? "Landing Page (Masonry)"
, destination ? "/index.html"
, colorScheme ? {
    backgroundColor = "#fdf6e3";
    rowColor = "#6c71c4";
    hoverColor = "#268bd2";
    itemColor = "#2aa198";
  }
, enableGiphySearch ? true
, enableUrlEncode ? true
, ...
}:

with lib;

writeTextFile
{
  name = "landingpage";
  destination = destination;
  text = with colorScheme;
    ''
          <!doctype html>
          <html>
            <head>
              <meta charset="utf-8">
              <title>${title}</title>

                <!-- The font -->
                <link href="https://fonts.googleapis.com/css?family=Dosis&display=swap" rel="stylesheet">

                <!-- The Masonry : https://masonry.desandro.com/ -->
                <script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>

                <style>
                    :root{
                        font-family: 'Dosis', sans-serif;
                    }
                    body {
                        margin-left:0px;
                        margin-right:0px;
                        padding-left:0px;
                        padding-right:0px;
                        background-color: ${backgroundColor};
                    }

                    .container {
                        margin-left:0px;
                        margin-right:0px;
                        padding-left:0px;
                        padding-right:0px;
                    }
                    .row {
                        /*width: 440px ;*/
                        width: 530px;
                        border-color:  ${rowColor};
                        border-width: 3px;
                        border-style: solid;
                        margin: 6px;
                        height: fit-content;
                    }
                    .row-container {
                      display: grid;
                      grid-template-rows: 6em 2em;
                      grid-template-columns: auto;
                      grid-template-areas:
                          "input input"
                          "encode decode";
                    }
                    .row-container.giphy-search {
                      display: grid;
                      grid-template-rows: 2em;
                      grid-template-columns: 70% 30%;
                      grid-template-areas: "input button";
                    }
                    .giphy-search input {
                      grid-area: input;
                      margin: 0.4em;
                    }
                    .giphy-search button {
                      grid-area: button;
                    }
                    .url-encoder #encodingBox {
                      margin: 3px;
                      grid-area: input;
                    }
                    .url-encoder .encode {
                      margin: 3px;
                      grid-area: encode;
                    }
                    .url-encoder .decode {
                      margin: 3px;
                      grid-area: decode;
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
                        background-color:  ${rowColor};
                        color: ${backgroundColor};
                        padding-top: 7px;
                        padding-bottom: 7px;
                    }
                    .item {
                        display: grid;
                        grid-template-columns: 200px;
                        grid-template-rows: auto;
                        grid-template-areas:
                          "image"
                          "text";
                        margin: 6px;
                        border-style: solid;
                        border-width: 3px;
                        border-color: ${itemColor};
                        background-color: ${itemColor};
                    }
                    .item-image {
                        grid-area: image;
                        width: 200px;
                        height: 144px;
                    }
                    .item-caption{
                        grid-area: text;
                        padding-bottom: 3px;
                    }
                    button,
                    a,
                    a:link,
                    a:active,
                    a:visited {
                        text-decoration: none;
                        color: ${backgroundColor};
                        background-color: ${itemColor};
                        border: 0px;
                    }
                    button:hover,
                    a:hover {
                        text-decoration: none;
                        color: ${backgroundColor};
                        background-color: ${hoverColor};
                        border: 0px;
                    }
                </style>

            </head>

            <!-- URL Encoder -->
            <script type="text/javascript">
              function boxEncode() {
                 area = document.getElementById("encodingBox")
                 var unencoded = area.value;
                 area.value = encodeURIComponent(unencoded).replace(/'/g, "%27").replace(/"/g, "%22");
              }
              function boxDecode() {
                 area = document.getElementById("encodingBox")
                 var encoded = area.value;
                 area.value = decodeURIComponent(encoded).replace(/'/g, "%27").replace(/"/g, "%22");
              }
            </script>

            <!-- Giphy Search -->
            <script type="text/javascript">
              function doGiphySearch() {
                queryElement = document.getElementById("giphyQuery")
                var query = queryElement.value;
                window.open(`https://giphy.com/search/''${query}`);
              }
              function boxDecode() {
                area = document.getElementById("encodingBox")
                var encoded = area.value;
                area.value = decodeURIComponent(encoded).replace(/'/g, "%27").replace(/"/g, "%22");
              }
            </script>

            <body>

                <div class="container grid" id="content" data-masonry='{ "itemSelector": ".row", "columnWidth": 10}'>
                    Oh no! If you're reading this, something went wrong. :(
                </div>

              <!-- item creation -->
              <script>

                const rowText = text => text ? `<div class="row-text"><pre>''${text}</pre></div>` : "";
                const rowTitle = title => title ? `<h2 class="row-title"> ''${title} </h2>` : "";
                const subItems = items => items.map(subItem => createSubItem(subItem)).join("");
                const createItemRow = item => `
                  <div class = "row" >
                  ''${rowTitle (item.title)}
                  ''${rowText(item.text)}
                  <div class="row-items">''${subItems(item.items)}</div>
                  </div>
                `;
                const createSubItem = ({ label, href, image }) => {
                  const shortLabel = (label.length > 28) ? `''${label.substring(0,25)}...` : label;
                  return `
                  <div class="item">
                  <a target="_blank" rel="noopener noreferrer" href="''${href}" class="thumbnail">
                  <img src="''${image}" class="item-image">
                  <div class="item-caption" style="text-align:center;font-weight:bold">
                  ''${shortLabel}
                  </div>
                  </a>
                  </div>
                  `;
                }

           /**
             * Return a random element from an array that is
             * different than `last` (as long as the array has > 1 items).
             * Return null if the array is empty.
             * source : https://stackoverflow.com/questions/4550505/getting-a-random-value-from-a-javascript-array
             */
             function getRandomDifferent(arr, last = undefined) {
             if (arr.length === 0) {
             return;
             } else if (arr.length === 1) {
             return arr[0];
             } else {
             let num = 0;
             do {
             num = Math.floor(Math.random() * arr.length);
             } while (arr[num] === last);
             return arr[num];
             }
             }

             function giphySearch() {
             return `
             <div class="row">
             ''${rowText("Giphy Search")}
             <div class="row-container giphy-search">
             <input type="text" id="giphyQuery"/>
             <button type="button" class="encode" onclick="doGiphySearch()">Search</button>
             </div>
             </div>
             </div>
             `;
             }

             function encoder(){
             return `
             <div class="row url-encoder">
             ''${rowText("URL Encoder/Decoder")}
             <div class="row-container">
             <textarea id="encodingBox">http://localhost:4444/oauth2/token?market=au&bla=blubb</textarea>
             <button type="button" class="encode" onclick="boxEncode()">Encode</button>
             <button type="button" class="decode" onclick="boxDecode()">Decode</button>
             </div>
             </div>
             </div>
             `;
             }

      /* [  THE CONTENT ] */

      const contentItems = ${builtins.toJSON jsonConfig};


      /* DOM overwriting */

      const container = document.querySelector('#content');
      container.innerHTML = [${concatStringsSep "," [
                                                 (optionalString enableGiphySearch "giphySearch()")
                                                 (optionalString enableUrlEncode "encoder()")
                                               ]}].concat(contentItems.map(item => createItemRow(item))).join("");

          </script>
        </body>
      </html>
    '';
}
