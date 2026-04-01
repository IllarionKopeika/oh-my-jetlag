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
    locale = I18n.locale.to_s
    visited_countries = Airport.where(id: visited_airports).distinct.pluck(:country_id)

    continents = Continent.includes(regions: { countries: :airports }).map do |continent|
      regions = continent.regions.map do |region|
        countries = region.countries.map do |country|
          visited = visited_countries.include?(country.id)
          {
            id: country.id,
            name: country.name,
            code: country.code,
            flag_url: country.flag_url,
            visited: visited
          }
        end
        visited_count = countries.count { |country| country[:visited] }
        {
          id: region.id,
          name: region.name,
          countries: countries.sort_by do |country|
            [
              country[:visited] ? 0 : 1,
              country[:name][locale]
            ]
          end,
          visited_count: visited_count
        }
      end
      visited_count = regions.sum { |region| region[:visited_count] }
      {
        id: continent.id,
        name: continent.name,
        regions: regions.sort_by do |region|
          [
            -region[:visited_count],
            region[:name][locale]
          ]
        end,
        visited_count: visited_count
      }
    end

    continents.sort_by do |continent|
      [
        -continent[:visited_count],
        continent[:name][locale]
      ]
    end
  end
end
