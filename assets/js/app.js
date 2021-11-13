import '../css/app.scss'
import "phoenix_html"
import { Elm } from "../src/Main.elm"
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute(
  "content",
);

let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
});

const app = Elm.Main.init({
  node: document.getElementById('elm-main')
});

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;
