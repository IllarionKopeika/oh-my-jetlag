class Stats::AircraftStats
  def initialize(user)
    @user = user
  end

  def completed_flights
    @completed_flights ||= @user.flights.completed
  end

  # general
  def aircrafts_count
    completed_flights.select(:aircraft_id).distinct.count
  end

  def manufacturers_count
    completed_flights.joins(:aircraft).where.not(aircrafts: { manufacturer: nil }).distinct.count("aircrafts.manufacturer")
  end

  def first_aircraft
    flight = completed_flights.includes(:aircraft).order(departure_utc: :asc).first
    name = flight&.aircraft&.name
    name.present? ? name : "-"
  end

  # top aircrafts
  def all_aircrafts
    aircrafts = completed_flights.joins(:aircraft).where.not(aircrafts: { manufacturer: nil }).group(:aircraft_id).order(Arel.sql("COUNT(*) DESC")).count
    aircraft_ids = aircrafts.keys
    aircrafts_data = Aircraft.where(id: aircraft_ids).index_by(&:id)

    aircrafts.map do |aircraft_id, count|
      {
        aircraft: aircrafts_data[aircraft_id],
        count: count
      }
    end
  end

  def top_aircrafts
    all_aircrafts.first(5)
  end

  # aircrafts by manufacturer
  def aircrafts_by_manufacturer
    manufacturers = completed_flights.joins(:aircraft).where.not(aircrafts: { manufacturer: nil }).select("aircrafts.manufacturer, COUNT(DISTINCT aircrafts.id) AS aircrafts_count").group("aircrafts.manufacturer").order("aircrafts_count DESC").to_a

    return [] if manufacturers.empty?

    aircrafts = Aircraft.where(manufacturer: manufacturers.map(&:manufacturer)).select(:manufacturer, :manufacturer_logo).distinct.index_by(&:manufacturer)
    max = manufacturers.first.aircrafts_count.to_f

    manufacturers.map do |manufacturer|
      count = manufacturer.aircrafts_count.to_i
      manufacturer = manufacturer.manufacturer
      aircraft = aircrafts[manufacturer]

      {
        manufacturer: manufacturer,
        logo: aircraft&.manufacturer_logo,
        count: count,
        percent: max.zero? ? 0 : (count / max * 100).round
      }
    end
  end
end
