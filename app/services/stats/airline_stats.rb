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
    completed_flights.empty? ? "-" : completed_flights.order(departure_utc: :asc).first.airline.code
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
end
