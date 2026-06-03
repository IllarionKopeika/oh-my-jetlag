class RatingsController < ApplicationController
  def rating
    rating = Ratings::Rating.new(User.includes(:flights))

    @rating_by_flights = rating.rating_by_flights
    @rating_by_distance = rating.rating_by_distance
    @rating_by_duration = rating.rating_by_duration
  end
end
