class Aircraft < ApplicationRecord
  has_many :flights

  before_save :set_manufacturer
  after_commit :update_aircraft

  private

  def set_manufacturer
    self.manufacturer = self.name.split.first if self.name.present?
  end

  def update_aircraft
    UpdateAircraftJob.perform_later(self.id) if self.manufacturer.present?
  end
end
