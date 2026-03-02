import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    flights: Array,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v12",
      projection: "globe"
    })

    this.#settings()
    this.#setLanguage()

    this.map.on("load", () => {
      this.#addMarkers()
      this.#addLines()
      this.#fitMapToMarkers()
    })
  }

  #settings() {
    this.map.addControl(new mapboxgl.NavigationControl(), "top-right")
    this.map.setMinZoom(1)
    this.map.setMaxZoom(10)
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
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.popup_html)

      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #addLines() {
    this.flightsValue.forEach((flight, index) => {
      const from = [flight.from_coordinates[1], flight.from_coordinates[0]]
      const to = [flight.to_coordinates[1], flight.to_coordinates[0]]
      const straight = [from, to]
      const sourceId = `flight-line-${index}`
      const shadowLayerId = `flight-line-shadow-${index}`
      const lineLayerId = `flight-line-${index}`

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
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 30, duration: 1500 })
  }
}
