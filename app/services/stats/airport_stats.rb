class Stats::AirportStats
  def initialize(user)
    @user = user
  end

  def completed_flights
    @completed_flights ||= @user.flights.completed
  end

  # general
  def airports_count
    completed_flights.pluck(:departure_airport_id, :arrival_airport_id).flatten.uniq.count
  end

  def departure_airports_count
    completed_flights.select(:departure_airport_id).distinct.count
  end

  def arrival_airports_count
    completed_flights.select(:arrival_airport_id).distinct.count
  end

  def first_airport
    completed_flights.empty? ? "-" : completed_flights.order(departure_utc: :asc).first.departure_airport.code
  end

  # visits
  def all_airport_visits
    airport_ids = completed_flights.pluck(:departure_airport_id, :arrival_airport_id).flatten
    ids_counts = airport_ids.tally
    sorted_counts = ids_counts.sort_by { |_, count| -count }
    airports = Airport.where(id: sorted_counts.map(&:first)).index_by(&:id)
    max = sorted_counts.first&.last.to_f

    sorted_counts.map do |airport_id, count|
      {
        airport: airports[airport_id],
        count: count,
        percent: max.zero? ? 0 : (count / max * 100).round
      }
    end
  end

  def top_airport_visits
    all_airport_visits.first(5)
  end

  # by countries
  def all_airports_by_countries
    airport_ids = completed_flights.pluck(:departure_airport_id, :arrival_airport_id).flatten.uniq
    Airport.where(id: airport_ids).group(:country).order(Arel.sql("COUNT(*) DESC")).count
  end

  def top_airports_by_countries
    all_airports_by_countries.first(5)
  end
end
