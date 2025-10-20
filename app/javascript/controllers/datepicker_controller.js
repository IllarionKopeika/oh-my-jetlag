import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="datepicker"
export default class extends Controller {
  connect() {
    flatpickr.localize(flatpickr.l10ns.ru)
    flatpickr(this.element, {
      position: "auto center",
      minDate: "2021-09-23",
      maxDate: new Date().fp_incr(365),
      dateFormat: "d-M-Y",
      disableMobile: "true"
    })
  }
}
