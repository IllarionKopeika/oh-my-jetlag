class Ratings::Rating
  def initialize(users)
    @users = users
  end

  def rating_by_flights
    rating.sort_by { |user| -user[:flights_count] }
  end

  def rating_by_distance
    rating.sort_by { |user| -user[:flights_distance] }
  end

  def rating_by_duration
    rating.sort_by { |user| -user[:flights_duration] }
  end

  def rating
    @users.map do |user|
      {
        nickname: user.nickname,
        flights_count: user.flights.completed.size,
        flights_distance: user.flights.completed.sum(:distance).round(2),
        flights_duration: user.flights.completed.sum(:duration)
      }
    end
  end
end
