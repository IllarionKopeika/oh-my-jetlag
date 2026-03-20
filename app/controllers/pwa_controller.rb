class PwaController < ApplicationController
  allow_unauthenticated_access only: %i[ manifest ]

  def manifest
    render template: "pwa/manifest", formats: [ :json ]
  end
end
