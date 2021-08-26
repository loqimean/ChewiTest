import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = [ "item", "lessControl", "moreControl" ]
  get limitShowValue() {
    return 5
  }

  connect() {
    if (this.itemTargets.length > this.limitShowValue){
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
      if (index >= this.limitShowValue) {
        element.hidden = state
      }
    })

    this.lessControlTarget.hidden = state
    this.moreControlTarget.hidden = !state
  }
}
