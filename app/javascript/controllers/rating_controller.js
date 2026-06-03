import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "flights", "flightsBadge", "distance", "distanceBadge", "duration", "durationBadge" ]

  showFlights() {
    this.flightsTarget.classList.remove("d-none")
    this.flightsBadgeTarget.classList.remove("text-bg-info")
    this.flightsBadgeTarget.classList.add("text-bg-primary")

    this.distanceTarget.classList.add("d-none")
    this.distanceBadgeTarget.classList.remove("text-bg-primary")
    this.distanceBadgeTarget.classList.add("text-bg-info")

    this.durationTarget.classList.add("d-none")
    this.durationBadgeTarget.classList.remove("text-bg-primary")
    this.durationBadgeTarget.classList.add("text-bg-info")
  }

  showDistance() {
    this.distanceTarget.classList.remove("d-none")
    this.distanceBadgeTarget.classList.remove("text-bg-info")
    this.distanceBadgeTarget.classList.add("text-bg-primary")

    this.flightsTarget.classList.add("d-none")
    this.flightsBadgeTarget.classList.remove("text-bg-primary")
    this.flightsBadgeTarget.classList.add("text-bg-info")

    this.durationTarget.classList.add("d-none")
    this.durationBadgeTarget.classList.remove("text-bg-primary")
    this.durationBadgeTarget.classList.add("text-bg-info")
  }

  showDuration() {
    this.durationTarget.classList.remove("d-none")
    this.durationBadgeTarget.classList.remove("text-bg-info")
    this.durationBadgeTarget.classList.add("text-bg-primary")

    this.flightsTarget.classList.add("d-none")
    this.flightsBadgeTarget.classList.remove("text-bg-primary")
    this.flightsBadgeTarget.classList.add("text-bg-info")

    this.distanceTarget.classList.add("d-none")
    this.distanceBadgeTarget.classList.remove("text-bg-primary")
    this.distanceBadgeTarget.classList.add("text-bg-info")
  }


}
