class AirportsController < ApplicationController
  def search
    render json: Airport
      .where("code ILIKE :q OR name ILIKE :q", q: "%#{params[:q].to_s.downcase}%")
      .order(:code)
      .limit(10)
      .select(:code, :name)
  end
end
