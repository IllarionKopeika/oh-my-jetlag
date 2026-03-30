class Stats::AircraftStats
  def initialize(user)
    @user = user
  end

  def completed_flights
    @user.flights.completed
  end

  # general
  def aircrafts_count
    completed_flights.select(:aircraft_id).distinct.count
  end

  def manufacturers_count
    completed_flights.joins(:aircraft).distinct.count("aircrafts.manufacturer")
  end

  def first_aircraft
    if completed_flights.empty? || completed_flights.order(departure_utc: :asc).first.aircraft.name.empty?
      "-"
    else
      completed_flights.order(departure_utc: :asc).first.aircraft.name
    end
  end

  # top aircrafts
  def all_aircrafts
    aircrafts = completed_flights.flat_map { |flight| [ flight.aircraft ] }.group_by { |aircraft| aircraft }.transform_values(&:count)
    sorted_aircrafts = aircrafts.sort_by { |_, count| -count }

    sorted_aircrafts.map do |aircraft, count|
      {
        aircraft: aircraft,
        count: count
      }
    end
  end

  def top_aircrafts
    all_aircrafts.first(5)
  end
end
