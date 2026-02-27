class ApiFlight
  def initialize(flight_params, user)
    @flight_params = flight_params
    @user = user
  end

  def call
    airline = Airline.find_or_create_by!(code: @flight_params[:airline_code].to_s.upcase)
    aircraft = Aircraft.find_or_create_by!(name: @flight_params[:aircraft_model].to_s)
    departure_airport = Airport.find_or_create_by!(code: @flight_params[:departure_airport_code].to_s.upcase) do |airport|
      airport.country = Country.find_by(code: @flight_params[:departure_country_code].to_s.upcase)
    end
    arrival_airport = Airport.find_or_create_by!(code: @flight_params[:arrival_airport_code].to_s.upcase) do |airport|
      airport.country = Country.find_by(code: @flight_params[:arrival_country_code].to_s.upcase)
    end

    flight = Flight.find_or_create_by(
      airline: airline,
      number: @flight_params[:number],
      departure_utc: @flight_params[:departure_utc],
      departure_airport: departure_airport,
      arrival_airport: arrival_airport
    ) do |f|
      f.departure_local = @flight_params[:departure_local]
      f.arrival_utc = @flight_params[:arrival_utc]
      f.arrival_local = @flight_params[:arrival_local]
      f.distance = @flight_params[:distance]
      f.aircraft = aircraft
      f.data_source = @flight_params[:data_source]
    end

    UserFlight.find_or_create_by!(user: @user, flight: flight)

    return flight
  end
end
