import { Controller } from "stimulus";

export default class extends Controller {
  open() {
    let backdropDiv = document.createElement('div');
    let modalWindow = document.getElementsByClassName('modal')[0];
    let modalBackgroundCount = document.getElementsByClassName('modal-backdrop').length;

    if (modalWindow) {
      document.body.classList.add("modal-open");
      modalWindow.setAttribute("style", "display: block;");
      modalWindow.classList.add("show");
      backdropDiv.classList.add('modal-backdrop', 'fade', 'show');

      if (modalBackgroundCount == 0) {
        document.body.append(backdropDiv);
      }
    }
  }

  close() {
    document.body.classList.remove("modal-open");
    this.element.removeAttribute("style");
    this.element.classList.remove("show");
    [...document.getElementsByClassName("modal-backdrop")].forEach(div => {
      div.remove();
    });
  }
}
