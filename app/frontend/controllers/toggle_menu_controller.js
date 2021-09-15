import { Controller } from 'stimulus'

const LIMIT_SHOW_VALUE = 5
const HIDE_ELEMENTS_STATUS = true
const SHOW_ELEMENTS_STATUS = false

export default class extends Controller {
  static targets = [ "item", "toggleControl" ]
  static values = {
    visibility: Boolean,
    moreButton: String,
    lessButton: String
  }

  connect() {
    if (this.itemTargets.length > LIMIT_SHOW_VALUE){
      this.drawItems()
    } else {
      this.toggleControlTarget.hidden = HIDE_ELEMENTS_STATUS
    }
  }

  drawItems() {
    let state = this.visibilityValue

    this.itemTargets.forEach((element, index) => {
      if (index >= LIMIT_SHOW_VALUE) {
        element.hidden = !state
      }
    })

    let setButtonName = status => {
      if (status) {
        return `${ this.lessButtonValue } ↑`
      } else {
        return `${ this.moreButtonValue } ↓`
      }
    }

    this.toggleControlTarget.textContent = setButtonName(state)
    this.visibilityValue = !state
  }
}
