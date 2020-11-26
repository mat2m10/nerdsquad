require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "bootstrap";
// import { toggleVisibility } from "../plugins/toggleVisibility"
import { moveAround } from "../plugins/moveAround";
import { positionElement } from "../plugins/positionElement";
import { initGameroomCable } from "../channels/gameroom_channel";
// import { dice } from '../components/dice';
import { popItUp } from '../components/dice';
import { navbar } from '../components/navbar';
document.addEventListener('turbolinks:load', () => {
  moveAround();
  positionElement();
  initGameroomCable();
  navbar();
  // dice;
});

let movable = document.querySelectorAll(`.movable`);
if (movable.length > 0) {
  let componentName = movable[0].className.substr(8)
  movable.forEach((i) => {
    let height = document.getElementById(`${componentName}_height`)
    let width = document.getElementById(`${componentName}_width`)
    let angle = document.getElementById(`${componentName}_angle`)
    if (height != null) {
      height.addEventListener('input', (e) => {
        i.style.height = `${e.currentTarget.value}px`
      })
      width.addEventListener('input', (e) => {
        i.style.width = `${e.currentTarget.value}px`
      })
      angle.addEventListener('input', (e) => {
        i.style.transform = `rotate(${e.currentTarget.value}deg)`
      })
    }
  })
}
