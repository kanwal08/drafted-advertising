import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile-search-form"
export default class extends Controller {
  static targets = [ "form"]

  connect() {
    $('.select2-form').on('select2:select', function () {
      let event = new Event('change', {bubbles: true}) // fire a native event
      this.dispatchEvent(event);
    });
  }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.formTarget.requestSubmit()
    }, 200)
  }
}
