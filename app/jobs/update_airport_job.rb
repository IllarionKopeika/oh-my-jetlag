class UpdateAirportJob < ApplicationJob
  require "httparty"
  queue_as :default

  def perform(airport_id)
    airport = Airport.find(airport_id)
    return unless airport

    url = "https://aviation-data1.p.rapidapi.com/airports/iata/#{airport.code}"
    Rails.logger.info "URL > #{url}"
    headers = {
      "x-rapidapi-key" => ENV.fetch("AVIATION_DATA_KEY"),
      "x-rapidapi-host" => ENV.fetch("AVIATION_DATA_HOST"),
      "Content-Type" => "application/json"
    }

    response = HTTParty.get(url, headers: headers)
    Rails.logger.info "Airport response > #{response}"

    if response.success?
      res_data = JSON.parse(response.body, symbolize_names: true)
      Rails.logger.info "Res data > #{res_data}"

      if res_data.dig(:data).blank?
        reset_fields(airport)
      else
        airport_data = res_data[:data]
        Rails.logger.info "Airport data > #{airport_data}"
        airport.update!(
          name: airport_data.dig(:name),
          city: airport_data.dig(:municipality),
          timezone: airport_data.dig(:timezone),
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
    airport_name = "Unknown Airport #{airport.code}"
    airport.update!(name: airport_name)
  end
end

# IATA DECODER

# # url = "https://iata-code-decoder.p.rapidapi.com/airports"
# headers = {
#   "x-rapidapi-key" => ENV.fetch("IATA_DECODER_KEY"),
#   "x-rapidapi-host" => ENV.fetch("IATA_DECODER_HOST")
# }
# querystring = {
#   query: airport.code
# }
#
# response = HTTParty.get(url, headers: headers, query: querystring)
