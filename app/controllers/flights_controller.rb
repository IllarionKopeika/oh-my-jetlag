class FlightsController < ApplicationController
  def search;end

  def fetch
    flight_number = format_flight_number(params[:flight_number])
    departure_date = params[:departure_date]

    @flight_data = FlightFetcher.new(flight_number, departure_date).call
    Rails.logger.info "Flight data: #{@flight_data}"

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  private

  def format_flight_number(flight_number)
    flight_number.to_s.gsub(/[[:space:]]+/, "").upcase
  end
end
