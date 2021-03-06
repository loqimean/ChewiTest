import { Controller } from "stimulus";
import { Modal } from 'bootstrap';

export default class extends Controller {

  connect() {
    this.modal = new Modal(document.getElementById('myModal'), {
      backdrop: 'static'
    });

    this.modal.show();
  }

  disconnect() {
    this.modal.hide();
  }

  close() {
    this.element.closest('turbo-frame[src]').src = '';
    this.element.remove();
  }

  afterSubmitClearUrl() {
    let turboFrame = this.element.closest('turbo-frame[src]');
    turboFrame.src = turboFrame.src.slice(-1)[0] == '/' ? turboFrame.src : turboFrame.src + '/';
  }
}
