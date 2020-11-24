import consumer from "./consumer";

const initGameroomCable = () => {
    const elementsContainer = document.getElementById('elements');
    const messagesContainer = document.getElementById('messages');
    if (elementsContainer) {
      const id = elementsContainer.dataset.gameroomId;
      consumer.subscriptions.create({ channel: "GameroomChannel", id: id }, {
        received(data) {
          if (data.message) {
            messagesContainer.insertAdjacentHTML('beforeend', data.message);
            messagesContainer.lastChild.scrollIntoView();
          } else {
            Turbolinks.visit(window.location.pathname);
          }
        },
      });
    }
  }

export { initGameroomCable };
