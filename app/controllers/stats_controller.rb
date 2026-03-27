class StatsController < ApplicationController
  def flight_stats
    @flight_stats = Stats::FlightStats.new(Current.user)
  end

  def airport_stats
    @airport_stats = Stats::AirportStats.new(Current.user)
  end
end
