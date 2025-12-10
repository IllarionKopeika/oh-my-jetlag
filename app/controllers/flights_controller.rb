class FlightsController < ApplicationController
  def search; end

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

  def create
    fp = flight_params
    airline = Airline.find_or_create_by!(code: fp[:airline_code].to_s.upcase)
    aircraft = Aircraft.find_or_create_by!(name: fp[:aircraft_model].to_s)
    departure_airport = Airport.find_or_create_by!(code: fp[:departure_airport_code].to_s.upcase) do |airport|
      airport.country = Country.find_by(code: fp[:departure_country_code].to_s.upcase)
    end
    arrival_airport = Airport.find_or_create_by!(code: fp[:arrival_airport_code].to_s.upcase) do |airport|
      airport.country = Country.find_by(code: fp[:arrival_country_code].to_s.upcase)
    end

    @flight = Flight.find_or_create_by(
      airline: airline,
      number: fp[:number],
      departure_utc: fp[:departure_utc],
      departure_airport: departure_airport,
      arrival_airport: arrival_airport
    ) do |flight|
      flight.departure_local = fp[:departure_local]
      flight.arrival_utc = fp[:arrival_utc]
      flight.arrival_local = fp[:arrival_local]
      flight.distance = fp[:distance]
      flight.aircraft = aircraft
    end

    UserFlight.find_or_create_by!(user: Current.user, flight: @flight)

    if @flight&.persisted?
      flash[:success] = t(".create_success")
      redirect_to flights_path
    else
      flash[:danger] = t(".error")
      render "search", status: :unprocessable_entity
    end
  end

  private

  def format_flight_number(flight_number)
    flight_number.to_s.gsub(/[[:space:]]+/, "").upcase
  end

  def flight_params
    params.require(:flight).permit(:number, :departure_airport_code, :departure_country_code, :departure_utc, :departure_local, :arrival_airport_code, :arrival_country_code, :arrival_utc, :arrival_local, :distance, :airline_code, :aircraft_model)
  end
end
