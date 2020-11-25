function navbar() {
  const element = document.querySelector('.menu-icon');
  element.addEventListener('click', () => {        
  element.classList.toggle("showing");        
});

  document.addEventListener('scroll', (event) => {
    console.log(window.pageYOffset)
    const menu = document.querySelector('.menu');
          
      if (window.pageYOffset >= 190){
        
        menu.classList.add('black');
      }
      else {              
        menu.classList.remove('black');
      }      
          
      });
};

export { navbar };
