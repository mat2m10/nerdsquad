const positionElement = () => { 
    document.querySelectorAll(".movablecontainer").forEach((div) => {
      let xPos = div.dataset.posx
      let yPos = div.dataset.posy
      div.style.left = xPos + 'px'
      div.style.top = yPos + 'px'
    })
  }
  
  export { positionElement };