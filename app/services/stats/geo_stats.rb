class Stats::GeoStats
  def initialize(user)
    @user = user
  end

  def completed_flights
    @completed_flights ||= @user.flights.completed
  end
end
