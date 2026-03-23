import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    departureCoordinates: Array,
    arrivalCoordinates: Array,
    departurePopup: String,
    arrivalPopup: String,
    marker: String
  }

  connect() {
    const modal = this.element.closest(".modal")
    modal.addEventListener("shown.bs.modal", () => this.#initMap(), { once: true })
  }

  #initMap() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v12",
      projection: "mercator"
    })

    this.#settings()
    this.#setLanguage()

    this.map.on("load", () => {
      this.#addMarkers()
      this.#addLine()
      this.#fitMapToMarkers()
    })
  }

  #settings() {
    this.map.addControl(new mapboxgl.NavigationControl(), "top-right")
    this.map.setMinZoom(1)
    this.map.setMaxZoom(12)
  }

  #setLanguage() {
    const lang = document.body.dataset.locale

    this.map.on("style.load", () => {
      const layers = this.map.getStyle().layers

      layers.forEach((layer) => {
        if (layer.layout && layer.layout["text-field"] && layer.id.includes("label")) {
          this.map.setLayoutProperty(layer.id, "text-field", ["get", `name_${lang}`])
        }
      })
    })
  }

  #addMarkers() {
    const createMarker = (coordinates, popupHTML, markerHTML) => {
      const popup = new mapboxgl.Popup().setHTML(popupHTML)

      const customMarker = document.createElement("div")
      customMarker.innerHTML = markerHTML

      new mapboxgl.Marker(customMarker)
        .setLngLat(coordinates)
        .setPopup(popup)
        .addTo(this.map)
    }

    createMarker(this.departureCoordinatesValue, this.departurePopupValue, this.markerValue)
    createMarker(this.arrivalCoordinatesValue, this.arrivalPopupValue, this.markerValue)
  }

  #addLine() {
    const from = [ this.departureCoordinatesValue[0], this.departureCoordinatesValue[1] ]
    const to = [ this.arrivalCoordinatesValue[0], this.arrivalCoordinatesValue[1] ]
    const straight = [ from, to ]
    const sourceId = "flight-line"
    const shadowLayerId = "flight-line-shadow"
    const lineLayerId = "flight-line"

    this.map.addSource(sourceId, {
      type: "geojson",
      data: {
        type: "Feature",
        geometry: {
          type: "LineString",
          coordinates: straight
        }
      }
    })

    this.map.addLayer({
      id: shadowLayerId,
      type: "line",
      source: sourceId,
      layout: {
        "line-join": "round",
        "line-cap": "round"
      },
      paint: {
        "line-color": "#441752",
        "line-width": 2
      }
    })

    this.map.addLayer({
      id: lineLayerId,
      type: "line",
      source: sourceId,
      layout: {
        "line-join": "round",
        "line-cap": "round"
      },
      paint: {
        "line-color": "#A888B5",
        "line-width": 1
      }
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    bounds.extend(this.departureCoordinatesValue)
    bounds.extend(this.arrivalCoordinatesValue)
    this.map.fitBounds(bounds, { padding: 30, duration: 1500 })
  }
}
