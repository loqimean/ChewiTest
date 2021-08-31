import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["modal"];

  launchModal() {
    let modalController = this.application.getControllerForElementAndIdentifier(
      this.modalTarget,
      "modal"
    );
      modalController.open();
  }
}
