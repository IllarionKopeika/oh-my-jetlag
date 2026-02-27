class FlightCalculator
  def self.call(flight)
    new(flight).call
  end

  def initialize(flight)
    @flight = flight
  end

  def call
    Rails.logger.info "сервис FlightCalculator начал работу для рейса #{@flight.id}"
    calculate_departure_utc
    calculate_arrival_utc
    calculate_duration
    calculate_status
    calculate_distance

    if @flight.changed?
      Rails.logger.info "Рейс #{@flight.id} обновился: #{@flight.changes}"
      @flight.save!
    else
      Rails.logger.info "Рейс #{@flight.id} не обновился"
    end
  end

  private

  def calculate_departure_utc
    return unless @flight.departure_airport&.timezone.present?
    return unless @flight.departure_local.present?

    departure_timezone = @flight.departure_airport.timezone
    @flight.departure_utc = ActiveSupport::TimeZone[departure_timezone].parse(@flight.departure_local).utc
  end

  def calculate_arrival_utc
    return unless @flight.arrival_airport&.timezone.present?
    return unless @flight.arrival_local.present?

    arrival_timezone = @flight.arrival_airport.timezone
    @flight.arrival_utc = ActiveSupport::TimeZone[arrival_timezone].parse(@flight.arrival_local).utc
  end

  def calculate_duration
    return unless @flight.departure_utc.present? && @flight.arrival_utc.present?

    @flight.duration = ((@flight.arrival_utc - @flight.departure_utc) / 60).to_i
  end

  def calculate_status
    return unless @flight.departure_utc.present?

    @flight.status = @flight.departure_utc.future? ? :upcoming : :completed
  end

  def calculate_distance
    return unless coordinates_present?

    @flight.distance = count_distance(@flight.departure_airport.latitude, @flight.departure_airport.longitude, @flight.arrival_airport.latitude, @flight.arrival_airport.longitude)
  end

  def coordinates_present?
    @flight.departure_airport&.latitude.present? &&
    @flight.departure_airport&.longitude.present? &&
    @flight.arrival_airport&.latitude.present? &&
    @flight.arrival_airport&.longitude.present?
  end

  def count_distance(dep_lat, dep_lng, arr_lat, arr_lng)
    rad = Math::PI / 180
    r = 6371

    dlat = (dep_lat - arr_lat) * rad
    dlon = (dep_lng - arr_lng) * rad

    a = Math.sin(dlat / 2)**2 +
        Math.cos(dep_lat * rad) * Math.cos(arr_lat * rad) *
        Math.sin(dlon / 2)**2

    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    (r * c).round(2)
  end
end
