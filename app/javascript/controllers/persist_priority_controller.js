import { Controller } from "stimulus"
import Sortable from "sortablejs"
import Rails from "@rails/ujs";

export default class extends Controller {
  connect() {
    console.log("Stimulus se conectó")
    this.sortable = Sortable.create(this.element, {
      ghostClass: "ghost",
      animation: 300,
      onEnd: this.end.bind(this)
    })
  }

  end(event){
    console.log("Stimulus se movió")
    let id = event.item.dataset.id;
    let data = new FormData();
    data.append("position", event.newIndex + 1);
    Rails.ajax({
      url: this.data.get("url").replace(":id", id),
      type: 'PATCH',
      data: data
    })
  }
}

// the connection is working in the all projects page
