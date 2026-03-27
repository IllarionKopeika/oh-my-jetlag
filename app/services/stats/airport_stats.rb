class Stats::AirportStats
  def initialize(user)
    @user = user
  end

  def completed_flights
    @user.flights.completed
  end

  # general
  def airports_count
    (completed_flights.map(&:departure_airport) + completed_flights.map(&:arrival_airport)).uniq.count
  end

  def departure_airports_count
    completed_flights.map(&:departure_airport).uniq.count
  end

  def arrival_airports_count
    completed_flights.map(&:arrival_airport).uniq.count
  end

  def first_airport
    completed_flights.empty? ? "-" : completed_flights.order(departure_utc: :asc).first.departure_airport.code
  end

  # visits
  def all_airport_visits
    visits = completed_flights.flat_map { |flight| [ flight.departure_airport, flight.arrival_airport ] }.group_by { |airport| airport }.transform_values(&:count)
    sorted_visits = visits.sort_by { |_, count| -count }
    max = sorted_visits.first&.last.to_f

    sorted_visits.map do |airport, count|
      percent = max.zero? ? 0 : (count / max * 100).round

      {
        airport: airport,
        count: count,
        percent: percent
      }
    end
  end

  def top_airport_visits
    all_airport_visits.first(5)
  end

  # by countries
  def all_airports_by_countries
    airports = completed_flights.flat_map { |flight| [ flight.departure_airport, flight.arrival_airport ] }.uniq.group_by(&:country).transform_values(&:count)
    airports.sort_by { |_, count| -count }
  end

  def top_airports_by_countries
    all_airports_by_countries.first(5)
  end
end
