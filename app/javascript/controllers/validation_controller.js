import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="validation"
export default class extends Controller {
  connect() {
    const forms = document.querySelectorAll(".needs-validation")

    Array.from(forms).forEach(form => {
      form.addEventListener("submit", event => {
        let valid = true

        const flatpickrInputs = form.querySelectorAll(".flatpickr-input[required]")

        flatpickrInputs.forEach(input => {
          const fp = input._flatpickr
          const altInput = fp?.altInput
          const hasValue = Boolean(input.value && input.value.trim() !== "")

          if (!hasValue) {
            valid = false
            altInput?.classList.add("is-invalid")
          } else {
            altInput?.classList.remove("is-invalid")
          }

          if (fp && !fp._validationListenerAdded) {
            fp._validationListenerAdded = true
            fp.config.onChange.push(() => {
              altInput?.classList.remove("is-invalid")
            })
          }
        })

        if (!form.checkValidity() || !valid) {
          event.preventDefault()
          event.stopPropagation()
          form.classList.add("was-validated")
        }
      }, false)
    })
  }
}
