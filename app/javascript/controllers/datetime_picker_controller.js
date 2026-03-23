import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "departure", "arrival" ]

  connect() {
    flatpickr.localize(flatpickr.l10ns.ru)

    const locale = this.element.dataset.locale

    this.departurePicker = flatpickr(this.departureTarget, {
      position: "auto center",
      minDate: "1990-01-01",
      maxDate: new Date().fp_incr(365),
      enableTime: true,
      time_24hr: true,
      altInput: true,
      altFormat: locale === "en" ? "M j, Y H:i" : "j M Y H:i",
      dateFormat: "Y-m-d H:i",
      disableMobile: true,
      onChange: this.departureChanged.bind(this)
    })

    this.arrivalPicker = flatpickr(this.arrivalTarget, {
      position: "auto center",
      minDate: "1990-01-01",
      maxDate: new Date().fp_incr(365),
      enableTime: true,
      time_24hr: true,
      altInput: true,
      altFormat: locale === "en" ? "M j, Y H:i" : "j M Y H:i",
      dateFormat: "Y-m-d H:i",
      disableMobile: true
    })
  }

  departureChanged(selectedDate) {
    if (selectedDate.length > 0) {
      const minArrival = new Date(selectedDate[0])
      minArrival.setHours(minArrival.getHours() - 24)

      const maxArrival = new Date(selectedDate[0])
      maxArrival.setHours(maxArrival.getHours() + 48)

      this.arrivalPicker.set("minDate", minArrival)
      this.arrivalPicker.set("maxDate", maxArrival)
    }
  }
}
