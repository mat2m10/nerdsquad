require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports

import "bootstrap";
// import { toggleVisibility } from "../plugins/toggleVisibility"
import { moveAround } from "../plugins/moveAround";
import { positionElement } from "../plugins/positionElement";
import { dice } from '../components/dice';
import { initGameroomCable } from "../channels/gameroom_channel";

document.addEventListener('turbolinks:load', () => {
  moveAround();
  positionElement();
  initGameroomCable();
  dice;
});
