class FlightsController < ApplicationController
  def index
    @upcoming_flights = Current.user.flights.upcoming.order(departure_local: :asc)
    @completed_flights = Current.user.flights.completed.order(departure_local: :desc)
  end

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

  def new
    @flight = Flight.new
  end

  def create
    service = case params[:flight][:data_source]
    when "api"
      ApiFlight
    when "manual_add"
      ManualAddFlight
    end

    result = service.new(flight_params, Current.user).call

    if result&.persisted?
      flash[:success] = t(".create_success")
      redirect_to flights_path
    else
      flash[:danger] = t(".error")
      render "search", status: :unprocessable_entity
    end
  end

  def map
    completed_flights = Current.user.flights.completed.includes(:departure_airport, :arrival_airport)
    @flights = completed_flights.map do |flight|
      {
        from_coordinates: flight.from_coordinates,
        to_coordinates: flight.to_coordinates
      }
    end

    airports = completed_flights.flat_map { |flight| [ flight.departure_airport, flight.arrival_airport ] }.uniq
    @markers = airports.map do |airport|
      {
        lat: airport.latitude,
        lng: airport.longitude,
        popup_html: render_to_string(partial: "popup", locals: { airport: airport }),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  private

  def format_flight_number(flight_number)
    flight_number.to_s.gsub(/[[:space:]]+/, "").upcase
  end

  def flight_params
    params.require(:flight).permit(:number, :departure_airport_code, :departure_country_code, :departure_utc, :departure_local, :arrival_airport_code, :arrival_country_code, :arrival_utc, :arrival_local, :distance, :airline_code, :aircraft_model, :data_source)
  end
end
