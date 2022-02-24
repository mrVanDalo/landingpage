function giphySearch() {
  return `
    <div class="row">
      <div class="row-text"><pre>Giphy Search</pre></div>
        <div class="row-container giphy-search">
          <input type="text" id="giphyQuery"/>
          <button type="button" class="encode" onclick="doGiphySearch()">Search</button>
        </div>
      </div>
    </div>
  `;
}
