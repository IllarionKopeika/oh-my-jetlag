class UpdateAircraftJob < ApplicationJob
  queue_as :default

  def perform(aircraft_id)
    aircraft = Aircraft.find(aircraft_id)
    return unless aircraft

    case aircraft.manufacturer
    when "Airbus"
      aircraft.update_column(manufacturer_logo: "https://upload.wikimedia.org/wikipedia/commons/5/5d/Airbus_Logo_2017.svg")
    when "ATR"
      aircraft.update_column(manufacturer_logo: "https://upload.wikimedia.org/wikipedia/commons/7/74/ATR_logo_2015.svg")
    when "Boeing"
      aircraft.update_column(manufacturer_logo: "https://upload.wikimedia.org/wikipedia/commons/4/4f/Boeing_full_logo.svg")
    when "Comac"
      aircraft.update_column(manufacturer_logo: "https://upload.wikimedia.org/wikipedia/en/c/c1/Commercial_Aircraft_Corporation_of_China_logo.svg")
    when "Embraer"
      aircraft.update_column(manufacturer_logo: "https://upload.wikimedia.org/wikipedia/commons/5/54/Embraer_logo.svg")
    when "Sukhoi"
      aircraft.update_column(manufacturer_logo: "https://upload.wikimedia.org/wikipedia/commons/3/35/Sukhoi_logo.svg")
    end
  end
end
