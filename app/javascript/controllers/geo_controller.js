import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { data: Array, locale: String }
  static targets = [ "continents", "regions", "countries" ]

  connect() {
    this.selectedContinent = this.dataValue[0]
    this.selectedRegion = this.selectedContinent.regions[0]

    this.renderContinents()
    this.renderRegions()
    this.renderCountries()
  }

  selectContinent(e) {
    const id = e.params.id

    this.selectedContinent = this.dataValue.find(continent => continent.id == id)
    this.selectedRegion = this.selectedContinent.regions[0]

    this.renderContinents()
    this.renderRegions()
    this.renderCountries()
  }

  selectRegion(e) {
    const id = e.params.id

    this.selectedRegion = this.selectedContinent.regions.find(region => region.id == id)

    this.renderRegions()
    this.renderCountries()
  }

  renderContinents() {
    this.continentsTarget.innerHTML = this.dataValue.map(continent => `
      <span class="badge rounded-pill me-1 ${continent.id === this.selectedContinent.id ? 'text-bg-primary' : 'text-bg-info text-white'}" role="button" data-action="click->geo#selectContinent" data-geo-id-param="${continent.id}">
        ${continent.name[[this.localeValue]]}
      </span>
    `).join("")
  }

  renderRegions() {
    this.regionsTarget.innerHTML = this.selectedContinent.regions.map(region => `
      <span class="badge rounded-pill me-1 ${region.id === this.selectedRegion.id ? 'text-bg-primary' : 'text-bg-info text-white'}" role="button" data-action="click->geo#selectRegion" data-geo-id-param="${region.id}">
        ${region.name[this.localeValue]}
      </span>
    `).join("")
  }

  renderCountries() {
    this.countriesTarget.innerHTML = this.selectedRegion.countries.map(country => `
      <div class="row align-items-center border-bottom">
        <div class="col-1 d-flex justify-content-start align-items-center">
          <img src="${country.flag_url}" alt="${country.code}">
        </div>
        <div class="col d-flex align-items-center" style="min-width: 0;">
          <p class="my-1 text-truncate w-100 text-center">${country.name[this.localeValue]}</p>
        </div>
        <div class="col-1 d-flex justify-content-end align-items-center">
          <i class="my-1 stats-icon ${country.visited ? 'fa-solid fa-circle-check text-success' : 'fa-regular fa-circle-xmark text-danger'}"></i>
        </div>
      </div>
    `).join("")
  }
}
