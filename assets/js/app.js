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
import { Elm } from "../src/Main.elm"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import topbar from "./topbar";

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute(
  "content",
);
let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
});

const app = Elm.Main.init({
  node: document.getElementById('elm-main')
});

app()

setTimeout(function () {
  $(".alert-box").fadeTo(500, 0).slideUp(500, function () {
    $(this).remove();
  });
}, 2000);

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", (info) => topbar.show());
window.addEventListener("phx:page-loading-stop", (info) => topbar.hide());

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;
