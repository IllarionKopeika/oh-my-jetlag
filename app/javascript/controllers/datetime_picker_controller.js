import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="datetime-picker"
export default class extends Controller {
  connect() {
    flatpickr.localize(flatpickr.l10ns.ru)

    const locale = this.element.dataset.locale

    flatpickr(this.element, {
      position: "auto center",
      minDate: "2021-09-23",
      maxDate: new Date().fp_incr(365),
      enableTime: true,
      time_24hr: true,
      altInput: true,
      altFormat: locale === "en" ? "M j, Y H:i" : "j M Y H:i",
      dateFormat: "Y-m-d H:i",
      disableMobile: "true"
    })
  }
}
