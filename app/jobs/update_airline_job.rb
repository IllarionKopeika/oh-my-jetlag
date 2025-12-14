class UpdateAirlineJob < ApplicationJob
  require "httparty"
  queue_as :default

  def perform(airline_id)
    airline = Airline.find(airline_id)
    return unless airline

    url = "https://iata-code-decoder.p.rapidapi.com/airlines"
    headers = {
      "x-rapidapi-key" => ENV.fetch("IATA_DECODER_KEY"),
      "x-rapidapi-host" => ENV.fetch("IATA_DECODER_HOST")
    }
    querystring = {
      query: airline.code
    }
    response = HTTParty.get(url, headers: headers, query: querystring)
    Rails.logger.info "Airport response > #{response}"

    if response.success?
      data = JSON.parse(response.body, symbolize_names: true)

      if data.dig(:data).blank?
        reset_fields(airline)
      else
        airline_data = data[:data][0]
        airline.update!(
          name: airline_data.dig(:name),
          logo_url: airline_data.dig(:logoSymbolUrl)
        )
      end
    else
      reset_fields(airline)
    end
  end

  private

  def reset_fields(airline)
    airline_name = "Unknown Airline #{airline.id}"
    airline.update!(
      name: airline_name,
      logo_url: 'https://res.cloudinary.com/dgjzxdtrf/image/upload/v1743490823/airplane_yix0kw.png'
    )
  end
end
