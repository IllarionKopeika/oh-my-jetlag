import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="year-filter"
export default class extends Controller {
  static targets = [ "group", "badge" ]

  filter(e) {
    const year = e.currentTarget.dataset.year

    this.groupTargets.forEach(group => {
      group.style.display =
        group.dataset.year === year ? "block" : "none"
    })

    this.#updateBadges(event.currentTarget)
  }

  showAll(e) {
    this.groupTargets.forEach(group => {
      group.style.display = "block"
    })

    this.#updateBadges(e.currentTarget)
  }

  #updateBadges(activeBadge) {
    this.badgeTargets.forEach(badge => {
      badge.classList.remove("text-bg-primary")
      badge.classList.add("text-bg-info")
      badge.classList.add("text-white")
    })

    activeBadge.classList.remove("text-bg-info")
    activeBadge.classList.add("text-bg-primary")
  }
}
