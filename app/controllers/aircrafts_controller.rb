class AircraftsController < ApplicationController
  def search
    render json: Aircraft
      .where("name ILIKE :q", q: "%#{params[:q]}%")
      .order(:name)
      .limit(10)
      .select(:name)
  end
end
