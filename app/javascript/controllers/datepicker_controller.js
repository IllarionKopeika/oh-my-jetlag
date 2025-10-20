import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="datepicker"
export default class extends Controller {
  connect() {
    flatpickr.localize(flatpickr.l10ns.ru)

    const locale = this.element.dataset.locale

    flatpickr(this.element, {
      position: "auto center",
      minDate: "2021-09-23",
      maxDate: new Date().fp_incr(365),
      altInput: true,
      altFormat: locale === "en" ? "M j, Y" : "j M Y",
      dateFormat: "d-M-Y",
      disableMobile: "true"
    })
  }
}
