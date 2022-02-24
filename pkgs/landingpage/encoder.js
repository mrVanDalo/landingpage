function encoder(){
    return `
      <div class="row url-encoder">
      <div class="row-text"><pre> URL Encoder/Decoder</pre></div>
          <div class="row-container">
          <textarea id="encodingBox">http://localhost:4444/oauth2/token?market=au&bla=blubb</textarea>
          <button type="button" class="encode" onclick="boxEncode()">Encode</button>
          <button type="button" class="decode" onclick="boxDecode()">Decode</button>
        </div>
        </div>
      </div>
    `;
}
