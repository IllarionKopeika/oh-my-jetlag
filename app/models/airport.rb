class Airport < ApplicationRecord
  belongs_to :country

  has_many :departing_flights, class_name: "Flight", foreign_key: "departure_airport_id", dependent: :destroy
  has_many :arriving_flights, class_name: "Flight", foreign_key: "arrival_airport_id", dependent: :destroy

  after_create_commit :update_airport

  private

  def update_airport
    UpdateAirportJob.perform_later(self.id)
  end
end
