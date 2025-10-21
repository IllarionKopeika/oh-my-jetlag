require "httparty"

class FlightFetcher
  def initialize(flight_number, departure_date)
    @flight_number = flight_number
    @departure_date = departure_date
  end

  def call
    url = "https://aerodatabox.p.rapidapi.com/flights/number/#{@flight_number}/#{@departure_date}"
    response = HTTParty.get(url, headers: headers, query: query_params)
    if response.success?
      parse_response(response)
    else
      { message: I18n.t("flight_not_found") }
    end
  rescue StandardError => e
    Rails.logger.error("Flight fetch error: #{e.message}")
    { message: I18n.t("flight_not_found") }
  end

  private

  def headers
    {
      "x-rapidapi-key" => ENV.fetch("FLIGHT_FETCHER_KEY"),
      "x-rapidapi-host" => ENV.fetch("FLIGHT_FETCHER_HOST")
    }
  end

  def query_params
    {
      withAircraftImage: "false",
      withLocation: "false",
      dateLocalRole: "Departure"
    }
  end

  def parse_response(response)
    response_data = JSON.parse(response.body, symbolize_names: true)

    if response_data.empty?
      { message: I18n.t("flight_not_found") }
    else
      response_data.map do |flight|
        flight_number = flight.dig(:number)

        {
          flight_number: flight_number.delete(" "),
          departure_airport_code: flight.dig(:departure, :airport, :iata),
          departure_country_code: flight.dig(:departure, :airport, :countryCode),
          departure_local: flight.dig(:departure, :scheduledTime, :local),
          departure_utc: flight.dig(:departure, :scheduledTime, :utc),
          arrival_airport_code: flight.dig(:arrival, :airport, :iata),
          arrival_country_code: flight.dig(:arrival, :airport, :countryCode),
          arrival_local: flight.dig(:arrival, :scheduledTime, :local),
          arrival_utc: flight.dig(:arrival, :scheduledTime, :utc)
        }
      end
    end
  end
end
