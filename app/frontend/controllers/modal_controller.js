import { Controller } from "stimulus";
import { Modal } from 'bootstrap';

// let modal = new Modal(document.getElementById('myModal'), {
//   keyboard: true,
//   backdrop: true
// });

export default class extends Controller {
  static targets = [ 'seeLink' ];

  connect() {
    let modal = new Modal(document.getElementById('myModal'));
    modal.show();
    console.log(this.element);
  }

  open() {
    console.log('hello');
    // let modal = new Modal(document.getElementById('myModal'), { backdrop: true});
    // console.log(document.getElementById('myModal'));
    // let backdropDiv = document.createElement('div');
    // let modalWindow = document.getElementsByClassName('modal')[0];
    // let modalBackgroundCount = document.getElementsByClassName('modal-backdrop').length;
    //
    // if (modalWindow) {
    //   document.body.classList.add("modal-open");
    //   modalWindow.setAttribute("style", "display: block;");
    //   modalWindow.classList.add("show");
    //
    //   backdropDiv.classList.add('modal-backdrop', 'fade', 'show');
    //   document.body.append(backdropDiv);
    // }
  }

  close() {
    console.log('bye');
    // document.body.classList.remove("modal-open");
    // this.element.removeAttribute("style");
    // this.element.classList.remove("show");
    [...document.getElementsByClassName("modal-backdrop")].forEach(div => {
      div.remove();
    });
  }
}
