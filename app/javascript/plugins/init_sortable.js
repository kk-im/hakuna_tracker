import Sortable from 'sortablejs';

const initSortable = () => {
  const projects = document.querySelector('.sortable');
  if (projects){
    Sortable.create(projects, {
      ghostClass: "ghost",
      animation: 300,
      onEnd: (event) => {
        const data = {
          elementId: event.item.dataset.id,
          oldPriority: event.oldIndex,
          newPriority: event.newIndex,
        }

        fetch('https://example.com/profile', {
          method: 'POST', // or 'PUT'
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(data),
        })
          .then(response => response.json())
          .then(data => {
            console.log('Success:', data);
          })
        // le voy a mandar con fetch 3 parametros a la funcion del backend, event-item.data-set.id, old-index y el new index
        // lo voy a recibir en el controlador de rails como params[], lo leo y sobre eso hago la lógica

        // debugger;
        // alert(`${event.item.dataset.id} moved to ${event.from}`);
        // alert(`${event.oldIndex} moved to ${event.newIndex}`);
      }
    });
  }
};

export { initSortable };
