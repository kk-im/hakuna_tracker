import Sortable from 'sortablejs';

const initSortable = () => {
  const projects = document.querySelector('.sortable');
  if (projects){
    Sortable.create(projects, {
      ghostClass: "ghost",
      animation: 300,
      onEnd: (event) => {
        // debugger;
        alert(`${event.item.dataset.id} moved to ${event.from}`);
        // alert(`${event.oldIndex} moved to ${event.newIndex}`);
      }
    });
  }
};

export { initSortable };
