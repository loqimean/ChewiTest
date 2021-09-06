import { Controller } from "stimulus";
import { Modal } from 'bootstrap';

export default class extends Controller {
  static values = { userLink: String };

  connect() {
    let modal = new Modal(document.getElementById('myModal'));
    let userLink = document.getElementById(`user-link-${this.userLinkValue}`);

    modal.show();
    console.log(this.userLinkValue);
    userLink.setAttribute('data-bs-toggle', 'modal');
    userLink.setAttribute('data-bs-target', '#myModal');
  }

  close() {
    [...document.getElementsByClassName("modal-backdrop")].forEach(div => {
      div.remove();
    });
  }
}
