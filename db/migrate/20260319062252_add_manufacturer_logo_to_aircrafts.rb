class AddManufacturerLogoToAircrafts < ActiveRecord::Migration[8.0]
  def change
    add_column :aircrafts, :manufacturer_logo, :string
  end
end
