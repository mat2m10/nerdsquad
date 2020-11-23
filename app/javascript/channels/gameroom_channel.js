import consumer from "./consumer";

const initGameroomCable = () => {
    const elementsContainer = document.getElementById('elements');
    const messagesContainer = document.getElementById('messages');
    if (elementsContainer) {
      const id = elementsContainer.dataset.gameroomId;
  
      consumer.subscriptions.create({ channel: "GameroomChannel", id: id }, {
        received(data) {
          console.log(data);  
          Turbolinks.visit(window.location.pathname);
            
        },
      });

      consumer.subscriptions.create({ channel: "GameroomChannel", id: id }, {
        received(data) {
          console.log(data);
          messagesContainer.insertAdjacentHTML('beforeend', data);
        }
      });

    }
  }

export { initGameroomCable };