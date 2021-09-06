import { Controller } from 'stimulus'

const LIMIT_SHOW_VALUE = 5
const HIDE_ELEMENTS_STATUS = true
const SHOW_ELEMENTS_STATUS = false

export default class extends Controller {
  static targets = [ "item", "lessControl", "moreControl" ]

  connect() {
    if (this.itemTargets.length > LIMIT_SHOW_VALUE){
      this.drawItems(HIDDEN_ELEMENTS_STATUS)
    } else {
      this.moreControlTarget.hidden = HIDDEN_ELEMENTS_STATUS
      this.lessControlTarget.hidden = HIDDEN_ELEMENTS_STATUS
    }
  }

  showMore() {
    this.drawItems(SHOW_ELEMENTS_STATUS)
  }

  showLess() {
    this.drawItems(HIDDEN_ELEMENTS_STATUS)
  }

  drawItems(state) {
    this.itemTargets.forEach((element, index) => {
      if (index >= LIMIT_SHOW_VALUE) {
        element.hidden = state
      }
    })

    this.lessControlTarget.hidden = state
    this.moreControlTarget.hidden = !state
  }
}
