class CompleteFlightJob < ApplicationJob
  queue_as :default

  def perform(flight_id)
    flight = Flight.find_by(id: flight_id)
    return unless flight&.upcoming?
    return unless flight&.arrival_utc <= Time.current

    flight.update!(status: :completed)
  end
end
