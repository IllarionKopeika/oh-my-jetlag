class AirportsController < ApplicationController
  def search
    render json: Airport
      .includes(:country)
      .where("airports.code ILIKE :q OR airports.name ILIKE :q", q: "%#{params[:q].to_s.downcase}%")
      .order(:code)
      .limit(10)
      .map { |airport|
        {
          code: airport.code,
          name: airport.name,
          country_code: airport.country.code
        }
      }
  end
end
