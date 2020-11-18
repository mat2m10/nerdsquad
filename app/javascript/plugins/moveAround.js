var initX = 0;
var initY = 0;
var name = "";
var test = 100;
const hash = "#";
const strX = "_posX";
const strY = "_posY";
const moveAround = () => {
  var container = document.querySelector(".movablecontainer");
  var activeItem = null;

  var active = false;
  if (container) {
    container.addEventListener("touchstart", dragStart, false);
    container.addEventListener("touchend", dragEnd, false);
    container.addEventListener("touchmove", drag, false);

    container.addEventListener("mousedown", dragStart, false);
    container.addEventListener("mouseup", dragEnd, false);
    container.addEventListener("mousemove", drag, false);
  }

  function dragStart(e) {

    if (e.target !== e.currentTarget) {
      active = true;

      // this is the item we are interacting with
      activeItem = e.target;

      if (activeItem !== null) {
        if (!activeItem.xOffset) {
          activeItem.xOffset = 0;
        }

        if (!activeItem.yOffset) {
          activeItem.yOffset = 0;
        }

        if (e.type === "touchstart") {
          activeItem.initialX = e.touches[0].clientX - activeItem.xOffset;
          activeItem.initialY = e.touches[0].clientY - activeItem.yOffset;
        } else {
          console.log("doing something!");
          if (initX === 0) {
            initX = e.screenX;
            initY = e.screenY;
            name = activeItem.className;
          }
          activeItem.initialX = e.clientX - activeItem.xOffset;
          activeItem.initialY = e.clientY - activeItem.yOffset;
        }
      }
    }
  }

  function dragEnd(e) {
    activeItem.xOffset = activeItem.currentX;
    activeItem.yOffset = activeItem.currentY;
    e.currentTarget.querySelector("#posX").value = getOffset(activeItem).left;
    e.currentTarget.querySelector("#posY").value = getOffset(activeItem).top;
    e.currentTarget.querySelector("form").submit();
    if (activeItem !== null) {
      activeItem.initialX = activeItem.currentX;
      activeItem.initialY = activeItem.currentY;
    }

    active = false;
    activeItem = null;
    initX = 0;
    initY = 0;
    name = "";
  }

  function drag(e) {
    if (active) {
      if (e.type === "touchmove") {
        e.preventDefault();

        activeItem.currentX = e.touches[0].clientX - activeItem.initialX;
        activeItem.currentY = e.touches[0].clientY - activeItem.initialY;
      } else {
        activeItem.currentX = e.clientX - activeItem.initialX;
        activeItem.currentY = e.clientY - activeItem.initialY;
      }

      activeItem.xOffset = activeItem.currentX;
      activeItem.yOffset = activeItem.currentY;

      setTranslate(activeItem.currentX, activeItem.currentY, activeItem);
      var form2 = document.querySelector((hash.concat(name)).concat(strX)).setAttribute("value", getOffset(activeItem).left);
      var form2 = document.querySelector((hash.concat(name)).concat(strY)).setAttribute("value", getOffset(activeItem).top);
    }
  }

  function setTranslate(xPos, yPos, el) {
    el.style.transform = "translate3d(" + xPos + "px, " + yPos + "px, 0)";
  }

  function getOffset(el) {
  const rect = el.getBoundingClientRect();
  return {
    left: rect.left + window.scrollX,
    top: rect.top + window.scrollY
  };
}
}
export{ moveAround };
