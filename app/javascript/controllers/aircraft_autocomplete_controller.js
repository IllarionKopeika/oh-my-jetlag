import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input", "results" ]

  search() {
    const query = this.inputTarget.value.trim()
    // console.log(query)

    if (query.length < 2) {
      this.clear()
      return
    }

    fetch(`/aircrafts/search?q=${query}`)
      .then(res => res.json())
      .then(aircrafts => this.render(aircrafts))
  }

  render(aircrafts) {
    this.resultsTarget.innerHTML = ""

    aircrafts.forEach(aircraft => {
      const li = document.createElement("li")
      li.className = "list-group-item list-group-item-action"

      const p = document.createElement("p")
      p.className = "mb-0 text-truncate w-100"
      p.style.whiteSpace = "nowrap"
      p.style.overflow = "hidden"
      p.style.textOverflow = "ellipsis"
      p.textContent = `${aircraft.name}`

      li.appendChild(p)
      li.addEventListener("click", () => this.select(aircraft.name))
      this.resultsTarget.appendChild(li)
    })
  }

  select(name) {
    this.inputTarget.value = name
    this.clear()
  }

  clear() {
    this.resultsTarget.innerHTML = ""
  }
}
