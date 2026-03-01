class Flight < ApplicationRecord
  scope :upcoming, -> { where(status: :upcoming) }
  scope :completed, -> { where(status: :completed) }

  belongs_to :airline, optional: true
  belongs_to :aircraft, optional: true

  belongs_to :departure_airport, class_name: "Airport", foreign_key: "departure_airport_id"
  belongs_to :arrival_airport, class_name: "Airport", foreign_key: "arrival_airport_id"

  has_many :user_flights, dependent: :destroy
  has_many :users, through: :user_flights

  enum :status, { upcoming: 0, completed: 1 }
  enum :flight_type, { domestic: 0, international: 1 }
  enum :data_source, { api: 0, manual_add: 1 }

  before_save :set_duration_status_type, if: :api?
  before_save :update_manually_added_flight, if: :manual_add?

  def from_coordinates
    [ departure_airport.latitude, departure_airport.longitude ] if departure_airport
  end

  def to_coordinates
    [ arrival_airport.latitude, arrival_airport.longitude ] if arrival_airport
  end

  private

  def set_duration_status_type
    # duration
    if departure_utc.present? && arrival_utc.present?
      self.duration = ((arrival_utc - departure_utc) / 60).to_i
    else
      self.duration = nil
    end

    # status
    if departure_utc.present?
      self.status = departure_utc.future? ? :upcoming : :completed
    else
      self.status = nil
    end

    # type
    if departure_airport.present? && arrival_airport.present?
      if departure_airport.country_id == arrival_airport.country_id
        self.flight_type = :domestic
      else
        self.flight_type = :international
      end
    else
      self.flight_type = nil
    end
  end

  def update_manually_added_flight
    # type
    if departure_airport.present? && arrival_airport.present?
      if departure_airport.country_id == arrival_airport.country_id
        self.flight_type = :domestic
      else
        self.flight_type = :international
      end
    else
      self.flight_type = nil
    end

    # utc
    if departure_airport.timezone.present?
      departure_timezone = departure_airport.timezone
      self.departure_utc = ActiveSupport::TimeZone[departure_timezone].parse(departure_local).utc
    end

    if arrival_airport.timezone.present?
      arrival_timezone = arrival_airport.timezone
      self.arrival_utc = ActiveSupport::TimeZone[arrival_timezone].parse(arrival_local).utc
    end

    # duration
    if departure_utc.present? && arrival_utc.present?
      self.duration = ((arrival_utc - departure_utc) / 60).to_i
    else
      self.duration = nil
    end

    # status
    if departure_utc.present?
      self.status = departure_utc.future? ? :upcoming : :completed
    else
      self.status = nil
    end

    # distance
    if departure_airport.latitude.present? && departure_airport.longitude.present? && arrival_airport.latitude.present? && arrival_airport.longitude.present?
      self.distance = count_distance(departure_airport.latitude, departure_airport.longitude, arrival_airport.latitude, arrival_airport.longitude)
    else
      self.distance = nil
    end
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
