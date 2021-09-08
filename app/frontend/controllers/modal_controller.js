import { Controller } from "stimulus";
import { Modal } from 'bootstrap';

export default class extends Controller {
  static values = { userLink: String };

  connect() {
    this.modal = new Modal(document.getElementById('myModal'));
    let userLink = document.getElementById(`user-link-${this.userLinkValue}`);

    this.modal.show();
    // userLink.setAttribute('data-bs-toggle', 'modal');
    // userLink.setAttribute('data-bs-target', '#myModal');
  }

  disconnect() {
    this.modal.hide();
  }

  close() {
    this.element.remove();
  }
}
