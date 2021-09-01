import { Controller } from "stimulus";

export default class extends Controller {
  open() {
    let backdropDiv = document.createElement('div');

    document.body.classList.add("modal-open");
    this.element.setAttribute("style", "display: block;");
    this.element.classList.add("show");
    backdropDiv.classList.add('modal-backdrop', 'fade', 'show')
    document.body.append(backdropDiv);
  }

  close() {
    document.body.classList.remove("modal-open");
    this.element.removeAttribute("style");
    this.element.classList.remove("show");
    document.getElementsByClassName("modal-backdrop")[0].remove();
  }
}
