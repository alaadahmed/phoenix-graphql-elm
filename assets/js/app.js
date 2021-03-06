// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import $ from 'jquery'

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"


import { Elm } from "../src/Main.elm"
var app = Elm.Main.init({
  node: document.getElementById('elm-main')
});

setTimeout(function () {
  $(".alert-box").fadeTo(500, 0).slideUp(500, function () {
    $(this).remove();
  });
}, 2000);
