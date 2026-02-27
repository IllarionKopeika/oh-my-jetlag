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

    fetch(`/airports/search?q=${query}`)
      .then(res => res.json())
      .then(airports => this.render(airports))
  }

  render(airports) {
    this.resultsTarget.innerHTML = ""

    airports.forEach(airport => {
      const li = document.createElement("li")
      li.className = "list-group-item list-group-item-action"

      const p = document.createElement("p")
      p.className = "mb-0 text-truncate w-100"
      p.style.whiteSpace = "nowrap"
      p.style.overflow = "hidden"
      p.style.textOverflow = "ellipsis"
      p.textContent = `${airport.code} — ${airport.name}`

      li.appendChild(p)
      li.addEventListener("click", () => this.select(airport.code))
      this.resultsTarget.appendChild(li)
    })
  }

  select(code) {
    this.inputTarget.value = code
    this.clear()
  }

  clear() {
    this.resultsTarget.innerHTML = ""
  }
}
