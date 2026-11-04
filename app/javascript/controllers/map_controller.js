import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    flights: Array,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    const isMobile = window.matchMedia("(max-width: 768px)").matches

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v12",
      projection: "globe",
      antialias: !isMobile,
      fadeDuration: isMobile ? 0 : 300
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
    this.markersValue.forEach((marker) => {
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      new mapboxgl.Marker({ element: customMarker })
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(new mapboxgl.Popup().setHTML(marker.popup_html))
        .addTo(this.map)
    })
  }

  #addLines() {
    const features = this.flightsValue.map((flight) => {
      const from = [flight.from_coordinates[1], flight.from_coordinates[0]]
      const to = [flight.to_coordinates[1], flight.to_coordinates[0]]
      return {
        type: "Feature",
        geometry: {
          type: "LineString",
          coordinates: [from, to]
        }
      }
    })

    this.map.addSource("flight-lines", {
      type: "geojson",
      data: {
        type: "FeatureCollection",
        features: features
      }
    })

    this.map.addLayer({
      id: "flight-lines-shadow",
      type: "line",
      source: "flight-lines",
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
      id: "flight-lines-main",
      type: "line",
      source: "flight-lines",
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
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 30, duration: 1500 })
  }
}
