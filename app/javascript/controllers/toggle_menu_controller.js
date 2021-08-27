import { Controller } from 'stimulus'

const LIMIT_SHOW_VALUE = 5

export default class extends Controller {
  static targets = [ "item", "lessControl", "moreControl" ]

  connect() {
    if (this.itemTargets.length > LIMIT_SHOW_VALUE){
      this.drawItems(true)
    } else {
      this.moreControlTarget.hidden = true
      this.lessControlTarget.hidden = true
    }
  }

  showMore() {
    this.drawItems(false)
  }

  showLess() {
    this.drawItems(true)
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
