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
import { initGameroomCable } from "../channels/gameroom_channel";
import { dice } from '../components/dice';
import { navbar } from '../components/navbar';
document.addEventListener('turbolinks:load', () => {
  moveAround();
  positionElement();
  initGameroomCable();
  navbar();
  // dice;
});


let movable = document.querySelectorAll(`.movable`);
if (movable) {
  let componentName = movable[0].className.substr(8)
  movable.forEach((i) => {
    let height = document.getElementById(`${componentName}_height`)
    let width = document.getElementById(`${componentName}_width`)
    let angle = document.getElementById(`${componentName}_angle`)
    height.addEventListener('input', (e) => {
      i.style.height = `${e.currentTarget.value}px`
    })
    width.addEventListener('input', (e) => {
      i.style.width = `${e.currentTarget.value}px`
    })
    angle.addEventListener('input', (e) => {
      i.style.transform = `rotate(${e.currentTarget.value}deg)`
    })
  })
}
// if (piece) {
//   piece.forEach((piece) => {
//     let heightPiece = document.getElementById('piece_height')
//     let widthPiece = document.getElementById('piece_width')
//     let anglePiece = document.getElementById('piece_angle')
//     heightPiece.addEventListener('input', (e) => {
//       console.log("hi")
//       piece.style.height = `${e.currentTarget.value}px`
//     })
//     widthPiece.addEventListener('input', (e) => {
//       piece.style.width = `${e.currentTarget.value}px`
//     })
//     anglePiece.addEventListener('input', (e) => {
//       piece.style.transform = `rotate(${e.currentTarget.value}deg)`
//     })
//   })
// }
// if (token) {
//     token.forEach((token) => {
//     let heightToken = document.getElementById('token_height')
//     let widthToken = document.getElementById('token_width')
//     let angleToken = document.getElementById('token_angle')
//     heightToken.addEventListener('input', (e) => {
//       token.style.height = `${e.currentTarget.value}px`
//     })
//     widthToken.addEventListener('input', (e) => {
//       token.style.width = `${e.currentTarget.value}px`
//     })
//     angleToken.addEventListener('input', (e) => {
//       token.style.transform = `rotate(${e.currentTarget.value}deg)`
//     })
//   })
// }


  
