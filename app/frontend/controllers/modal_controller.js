import { Controller } from "stimulus";
import { Modal } from 'bootstrap';

export default class extends Controller {

  connect() {
    this.modal = new Modal(document.getElementById('myModal'));

    this.modal.show();
  }

  disconnect() {
    this.modal.hide();
  }

  close() {
    this.element.closest('turbo-frame[src]').src = '';
    this.element.remove();
  }
}
