import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "flightNumber",
    "departureSection",
    "arrivalSection",
    "aircraftSection",
    "checkbox",
    "submitButton",
    "departureAirport",
    "departureCountry",
    "departureDatetime",
    "arrivalAirport",
    "arrivalCountry",
    "arrivalDatetime",
    "aircraftModel",
    "aircraftCheckbox"
  ]

  checkFlightNumber() {
    const flightNumber = this.flightNumberTarget.value.trim()

    if (flightNumber.length >= 3) {
      this.departureSectionTarget.classList.remove("d-none")
      this.checkDeparture()
      this.checkArrival()
      this.checkAircraft()
    } else {
      this.departureSectionTarget.classList.add("d-none")
      this.arrivalSectionTarget.classList.add("d-none")
      this.aircraftSectionTarget.classList.add("d-none")
      this.checkboxTarget.classList.add("d-none")
      this.submitButtonTarget.classList.add("disabled")
    }
  }

  checkDeparture() {
    const departureAirport = this.departureAirportTarget.value.trim()
    const departureCountry = this.departureCountryTarget.value.trim()
    const departureDatetime = this.departureDatetimeTarget.value.trim()

    if (departureAirport.length === 3 && departureCountry.length === 2 && departureDatetime.length === 16) {
      this.arrivalSectionTarget.classList.remove("d-none")
      this.checkArrival()
    } else {
      this.arrivalSectionTarget.classList.add("d-none")
      this.aircraftSectionTarget.classList.add("d-none")
      this.checkboxTarget.classList.add("d-none")
      this.submitButtonTarget.classList.add("disabled")
    }
  }

  checkArrival() {
    const arrivalAirport = this.arrivalAirportTarget.value.trim()
    const arrivalCountry = this.arrivalCountryTarget.value.trim()
    const arrivalDatetime = this.arrivalDatetimeTarget.value.trim()

    if (arrivalAirport.length === 3 && arrivalCountry.length === 2 && arrivalDatetime.length === 16) {
      this.aircraftSectionTarget.classList.remove("d-none")
      this.checkboxTarget.classList.remove("d-none")
      this.checkAircraft()
    } else {
      this.aircraftSectionTarget.classList.add("d-none")
      this.checkboxTarget.classList.add("d-none")
      this.submitButtonTarget.classList.add("disabled")
    }
  }

  checkAircraft() {
    this.updateSubmitButton()
  }

  toggleAircraftField(){
    if (this.aircraftCheckboxTarget.checked) {
      this.aircraftModelTarget.value = ""
      this.aircraftModelTarget.disabled = true
    } else {
      this.aircraftModelTarget.disabled = false
    }

    this.updateSubmitButton()
  }

  updateSubmitButton() {
    const aircraftModel = this.aircraftModelTarget.value.trim()
    const checkboxState = this.aircraftCheckboxTarget.checked

    if (checkboxState || aircraftModel.length > 3) {
      this.submitButtonTarget.classList.remove("disabled")
    } else {
      this.submitButtonTarget.classList.add("disabled")
    }
  }
}
