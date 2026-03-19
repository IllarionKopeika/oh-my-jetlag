class AddCityToAirports < ActiveRecord::Migration[8.0]
  def change
    add_column :airports, :city, :string
  end
end
