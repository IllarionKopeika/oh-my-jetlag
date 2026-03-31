class Stats::GeoStats
  def initialize(user)
    @user = user
  end

  def completed_flights
    @completed_flights ||= @user.flights.completed
  end

  # general
  def visited_airports
    completed_flights.pluck(:departure_airport_id, :arrival_airport_id).flatten.uniq
  end

  def countries_count
    Country.joins(:airports).where(airports: { id: visited_airports }).distinct.count
  end

  def regions_count
    Region.joins(countries: :airports).where(airports: { id: visited_airports }).distinct.count
  end

  def continents_count
    Continent.joins(regions: { countries: :airports }).where(airports: { id: visited_airports }).distinct.count
  end

  # countries
  def geo_tree
    Continent.includes(regions: { countries: :airports }).map do |continent|
      {
        id: continent.id,
        name: continent.name,
        regions: continent.regions.map do |region|
          {
            id: region.id,
            name: region.name,
            countries: region.countries.map do |country|
              {
                id: country.id,
                name: country.name,
                code: country.code,
                flag_url: country.flag_url,
                visited: country.airports.where(id: visited_airports).exists?
              }
            end
          }
        end
      }
    end
  end
end
