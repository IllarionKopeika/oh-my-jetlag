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
  enum :type, { domestic: 0, international: 1 }

  before_save :set_duration_status_type

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
        self.type = :domestic
      else
        self.type = :international
      end
    else
      self.type = nil
    end
  end
end
