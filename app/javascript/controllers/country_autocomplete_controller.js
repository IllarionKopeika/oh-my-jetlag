import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="country-autocomplete"
export default class extends Controller {
  static targets = [ "input", "results" ]

  search() {
    const query = this.inputTarget.value.trim()
    const locale = this.element.dataset.locale
    // console.log(query)
    // console.log(locale)

    if (query.length < 2) {
      this.clear()
      return
    }

    fetch(`/countries/search?q=${query}&locale=${locale}`)
      .then(res => res.json())
      .then(countries => this.render(countries))
  }

  render(countries) {
    this.resultsTarget.innerHTML = ""

    countries.forEach(country => {
      const li = document.createElement("li")
      li.className = "list-group-item list-group-item-action"

      const p = document.createElement("p")
      p.className = "mb-0 text-truncate w-100"
      p.style.whiteSpace = "nowrap"
      p.style.overflow = "hidden"
      p.style.textOverflow = "ellipsis"
      p.textContent = `${country.code} — ${country.name}`

      li.appendChild(p)
      li.addEventListener("click", () => this.select(country.code))
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
