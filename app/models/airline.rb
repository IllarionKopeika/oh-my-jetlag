class Airline < ApplicationRecord
  has_many :flights

  after_create_commit :update_airline

  private

  def update_airline
    UpdateAirlineJob.perform_later(self.id)
  end
end
