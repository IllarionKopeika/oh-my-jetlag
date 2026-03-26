class StatsController < ApplicationController
  def flight_stats
    @flight_stats = Stats::FlightStats.new(Current.user)
  end
end
