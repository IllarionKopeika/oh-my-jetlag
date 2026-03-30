class Stats::FlightStats
  def initialize(user)
    @user = user
  end

  def completed_flights
    @completed_flights ||= @user.flights.completed
  end

  # general
  def flights_count
    completed_flights.count
  end

  def international_flights_count
    completed_flights.international.count
  end

  def domestic_flight_count
    completed_flights.domestic.count
  end

  def routes_count
    completed_flights.select(:departure_airport_id, :arrival_airport_id).distinct.count
  end

  # routes
  def all_routes
    routes = completed_flights.select("departure_airport_id, arrival_airport_id, COUNT(*) as flights_count").group(:departure_airport_id, :arrival_airport_id).order("flights_count DESC")

    return [] if routes.empty?

    airport_ids = routes.map { |route| [ route.departure_airport_id, route.arrival_airport_id ] }.flatten.uniq
    airports = Airport.where(id: airport_ids).index_by(&:id)
    max = routes.first.flights_count.to_f

    routes.map do |route|
      {
        departure: airports[route.departure_airport_id],
        arrival: airports[route.arrival_airport_id],
        count: route.flights_count,
        percent: ((route.flights_count / max) * 100).round
      }
    end
  end

  def top_routes
    all_routes.first(5)
  end

  # limit
  def limit
    case flights_count
    when 0..4
      1
    when 5..9
      2
    when 10..14
      3
    when 15..19
      5
    when 20..29
      7
    else
      10
    end
  end

  # distance
  def total_distance
    completed_flights.sum(:distance).round(2)
  end

  def desc_distance_flights
    completed_flights.includes(:departure_airport, :arrival_airport).order(distance: :desc)
  end

  def asc_distance_flights
    completed_flights.includes(:departure_airport, :arrival_airport).order(distance: :asc)
  end

  def top_desc_distance_flights
    desc_distance_flights.limit(limit)
  end

  def top_asc_distance_flights
    asc_distance_flights.limit(limit)
  end

  # duration
  def total_duration
    completed_flights.sum(:duration)
  end

  def desc_duration_flights
    completed_flights.includes(:departure_airport, :arrival_airport).order(duration: :desc)
  end

  def asc_duration_flights
    completed_flights.includes(:departure_airport, :arrival_airport).order(duration: :asc)
  end

  def top_desc_duration_flights
    desc_duration_flights.limit(limit)
  end

  def top_asc_duration_flights
    asc_duration_flights.limit(limit)
  end
end
