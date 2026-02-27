class CountriesController < ApplicationController
  def search
    query = params[:q].to_s.downcase
    locale = params[:locale].to_s.downcase

    countries = Country
      .where("code ILIKE :q OR name ->> :locale ILIKE :q", q: "%#{query}%", locale: locale)
      .order(:code)
      .limit(10)
      .select(:code, :name)

    render json: countries.map { |country|
      {
        code: country.code,
        name: country.name[locale]
      }
    }
  end
end
