class CalculateFlightJob < ApplicationJob
  queue_as :default

  def perform(airport_id)
    airport = Airport.find(airport_id)
    return unless airport

    flights = Flight.where(departure_airport_id: airport.id).or(Flight.where(arrival_airport_id: airport.id))

    flights.each do |flight|
      FlightCalculator.call(flight)
    end
  end
end
