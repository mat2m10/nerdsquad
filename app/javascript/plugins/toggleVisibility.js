const toggleVisibility = () => {
  var creation1 = document.querySelector("#creation1")
  button1.addEventListener("click", function(click) {
    if (isClicked === false) {
      creation1.style.display = "block";
      console.log("jour")
      isClicked = true;
    } else {
      console.log("nuit")
      creation1.style.display = "none";
      isClicked = false;
    }
  });
}
export{ toggleVisibility };
