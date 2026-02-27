class ManualAddFlight
  def initialize(flight_params, user)
    @flight_params = flight_params
    @user = user
  end

  def call
    # flight number
    flight_number = @flight_params[:number].to_s.gsub(/[[:space:]]+/, "").upcase
    formatted_flight_number = "#{flight_number[0..1]} #{flight_number[2..]}"

    # airline
    airline_code = flight_number[0..1]
    airline = Airline.find_or_create_by!(code: airline_code)

    # aircraft
    aircraft = Aircraft.find_or_create_by!(name: @flight_params[:aircraft_model].to_s)

    # airports
    departure_airport = Airport.find_or_create_by!(code: @flight_params[:departure_airport_code].to_s.upcase) do |airport|
      airport.country = Country.find_by(code: @flight_params[:departure_country_code].to_s.upcase)
    end
    arrival_airport = Airport.find_or_create_by!(code: @flight_params[:arrival_airport_code].to_s.upcase) do |airport|
      airport.country = Country.find_by(code: @flight_params[:arrival_country_code].to_s.upcase)
    end

    flight = Flight.find_or_create_by(
      airline: airline,
      number: formatted_flight_number,
      departure_local: @flight_params[:departure_local],
      departure_airport: departure_airport,
      arrival_airport: arrival_airport
    ) do |f|
      f.arrival_local = @flight_params[:arrival_local]
      f.aircraft = aircraft
      f.data_source = @flight_params[:data_source]
    end

    UserFlight.find_or_create_by!(user: @user, flight: flight)

    return flight
  end
end
