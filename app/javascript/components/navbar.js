function navbar() {
  const element = document.querySelector('.menu-icon');
  if (element) {
    element.addEventListener('click', () => {
    element.classList.toggle("showing");
  });

    document.addEventListener('scroll', (event) => {
      const menu = document.querySelector('.menu');
        if (menu) {
          if (window.pageYOffset >= 10){
            menu.classList.add('black');
          }
          else {
            menu.classList.remove('black');
          }
        }
    });
  };
}

export { navbar };
