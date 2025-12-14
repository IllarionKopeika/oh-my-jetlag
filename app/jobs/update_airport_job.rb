class UpdateAirportJob < ApplicationJob
  require "httparty"
  queue_as :default

  def perform(airport_id)
    airport = Airport.find(airport_id)
    return unless airport

    url = "https://iata-code-decoder.p.rapidapi.com/airports"
    headers = {
      "x-rapidapi-key" => ENV.fetch("IATA_DECODER_KEY"),
      "x-rapidapi-host" => ENV.fetch("IATA_DECODER_HOST")
    }
    querystring = {
      query: airport.code
    }
    response = HTTParty.get(url, headers: headers, query: querystring)
    Rails.logger.info "Airport response > #{response}"

    if response.success?
      data = JSON.parse(response.body, symbolize_names: true)

      if data.dig(:data).blank?
        reset_fields(airport)
      else
        airport_data = data[:data][0]
        airport.update!(
          name: airport_data.dig(:name),
          timezone: airport_data.dig(:timeZone),
          latitude: airport_data.dig(:latitude),
          longitude: airport_data.dig(:longitude)
        )
      end
    else
      reset_fields(airport)
    end
  end

  private

  def reset_fields(airport)
    airport_name = "Unknown Airport #{airport.id}"
    airport.update!(name: airport_name)
  end
end
