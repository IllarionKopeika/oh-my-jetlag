class StatsController < ApplicationController
  def flight_stats
    @flight_stats = Stats::FlightStats.new(Current.user)
  end

  def airport_stats
    @airport_stats = Stats::AirportStats.new(Current.user)
  end

  def airline_stats
    @airline_stats = Stats::AirlineStats.new(Current.user)
  end

  def aircraft_stats
    @aircraft_stats = Stats::AircraftStats.new(Current.user)
  end

  def geo_stats
    @geo_stats = Stats::GeoStats.new(Current.user)
  end
end
