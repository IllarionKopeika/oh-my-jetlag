class Stats::AirlineStats
  def initialize(user)
    @user = user
  end

  def completed_flights
    @user.flights.completed
  end

  # general
  def airlines_count
    completed_flights.select(:airline_id).distinct.count
  end

  def first_airline
    completed_flights.empty? ? "-" : completed_flights.order(departure_utc: :asc).first.airline
  end

  # top airlines
  def all_airlines
    airlines = completed_flights.flat_map { |flight| [ flight.airline ] }.group_by { |airline| airline }.transform_values(&:count)
    sorted_airlines = airlines.sort_by { |_, count| -count }

    sorted_airlines.map do |airline, count|
      {
        airline: airline,
        count: count
      }
    end
  end

  def top_airlines
    all_airlines.first(5)
  end

  # airlines by distance
  def all_airlines_by_distance
    all_airlines = completed_flights.group_by(&:airline).transform_values { |flights| flights.sum(&:distance).to_f.round(2) }
    sorted_airlines = all_airlines.sort_by { |_, distance| -distance }
    max = sorted_airlines.first&.last.to_f

    sorted_airlines.map do |airline, distance|
      percent = max.zero? ? 0 : (distance / max * 100).round
      {
        airline: airline,
        distance: distance,
        percent: percent
      }
    end
  end

  def top_airlines_by_distance
    all_airlines_by_distance.first(5)
  end

  # airlines by duration
  def all_airlines_by_duration
    all_airlines = completed_flights.group_by(&:airline).transform_values { |flights| flights.sum(&:duration).round }
    sorted_airlines = all_airlines.sort_by { |_, duration| -duration }
    max = sorted_airlines.first&.last.to_f

    sorted_airlines.map do |airline, duration|
      percent = max.zero? ? 0 : (duration / max * 100).round
      {
        airline: airline,
        duration: duration,
        percent: percent
      }
    end
  end

  def top_airlines_by_duration
    all_airlines_by_duration.first(5)
  end
end
