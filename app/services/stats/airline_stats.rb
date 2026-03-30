class Stats::AirlineStats
  def initialize(user)
    @user = user
  end

  def completed_flights
    @completed_flights ||= @user.flights.completed
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
    airlines = completed_flights.group(:airline_id).order(Arel.sql("COUNT(*) DESC")).count
    airline_ids = airlines.keys
    airlines_data = Airline.where(id: airline_ids).index_by(&:id)

    airlines.map do |airline_id, count|
      {
        airline: airlines_data[airline_id],
        count: count
      }
    end
  end

  def top_airlines
    all_airlines.first(5)
  end

  # airlines by distance
  def all_airlines_by_distance
    airlines = completed_flights.group(:airline_id).order(Arel.sql("SUM(distance) DESC")).sum(:distance)
    airline_ids = airlines.keys
    airlines_data = Airline.where(id: airline_ids).index_by(&:id)
    max = airlines.values.first.to_f

    airlines.map do |airline_id, distance|
      {
        airline: airlines_data[airline_id],
        distance: distance.to_f.round(2),
        percent: max.zero? ? 0 : (distance / max * 100).round
      }
    end
  end

  def top_airlines_by_distance
    all_airlines_by_distance.first(5)
  end

  # airlines by duration
  def all_airlines_by_duration
    airlines = completed_flights.group(:airline_id).order(Arel.sql("SUM(duration) DESC")).sum(:duration)
    airline_ids = airlines.keys
    airlines_data = Airline.where(id: airline_ids).index_by(&:id)
    max = airlines.values.first.to_f

    airlines.map do |airline_id, duration|
      {
        airline: airlines_data[airline_id],
        duration: duration.round,
        percent: max.zero? ? 0 : (duration / max * 100).round
      }
    end
  end

  def top_airlines_by_duration
    all_airlines_by_duration.first(5)
  end
end
