class Stats::FlightStats
  def initialize(user)
    @user = user
  end

  def completed_flights
    @user.flights.completed
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
    all_routes = completed_flights.group(:departure_airport_id, :arrival_airport_id).order(Arel.sql("COUNT(*) DESC")).count
    airport_ids = all_routes.keys.flatten.uniq
    airports = Airport.where(id: airport_ids).index_by(&:id)

    routes_data = all_routes.map do |(departure_airport_id, arrival_airport_id), count|
      {
        departure: airports[departure_airport_id],
        arrival: airports[arrival_airport_id],
        count: count
      }
    end

    return [] if routes_data.empty?

    max = routes_data.first[:count].to_f

    routes_data.map do |route|
      route.merge(percent: ((route[:count] / max) * 100).round)
    end
  end

  def top_routes
    all_routes.first(5)
  end

  # distance
  def total_distance
    completed_flights.sum(:distance).round(2)
  end

  def desc_distance_flights
    completed_flights.order(distance: :desc)
  end

  def asc_distance_flights
    completed_flights.order(distance: :asc)
  end

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
    when 30..999999
      10
    end
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
    completed_flights.order(duration: :desc)
  end

  def asc_duration_flights
    completed_flights.order(duration: :asc)
  end

  def top_desc_duration_flights
    desc_duration_flights.limit(limit)
  end

  def top_asc_duration_flights
    asc_duration_flights.limit(limit)
  end
end
