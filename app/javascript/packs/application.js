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
  // dice;
});

let board = document.querySelectorAll(`.board`);
let heightBoard = document.getElementById('board_height')
let widthBoard = document.getElementById('board_width')
let angleBoard = document.getElementById('board_angle')

board.forEach((board) => {
  heightBoard.addEventListener('input', (e) => {
    board.style.height = `${e.currentTarget.value}px`
  })
  widthBoard.addEventListener('input', (e) => {
    board.style.width = `${e.currentTarget.value}px`
  })
  angleBoard.addEventListener('input', (e) => {
    board.style.transform = `rotate(${e.currentTarget.value}deg)`
  })
})

let piece = document.querySelectorAll(`.piece`);
let heightPiece = document.getElementById('piece_height')
let widthPiece = document.getElementById('piece_width')
let anglePiece = document.getElementById('piece_angle')

piece.forEach((piece) => {
  heightPiece.addEventListener('input', (e) => {
    piece.style.height = `${e.currentTarget.value}px`
  })
  widthPiece.addEventListener('input', (e) => {
    piece.style.width = `${e.currentTarget.value}px`
  })
  anglePiece.addEventListener('input', (e) => {
    piece.style.transform = `rotate(${e.currentTarget.value}deg)`
  })
})

let token = document.querySelectorAll(`.token`);
let heightToken = document.getElementById('token_height')
let widthToken = document.getElementById('token_width')
let angleToken = document.getElementById('token_angle')

token.forEach((token) => {
  heightToken.addEventListener('input', (e) => {
    token.style.height = `${e.currentTarget.value}px`
  })
  widthToken.addEventListener('input', (e) => {
    token.style.width = `${e.currentTarget.value}px`
  })
  angleToken.addEventListener('input', (e) => {
    token.style.transform = `rotate(${e.currentTarget.value}deg)`
  })
})
  
