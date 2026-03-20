class PwaController < ApplicationController
  def manifest
    render template: "pwa/manifest", formats: [ :json ]
  end
end
