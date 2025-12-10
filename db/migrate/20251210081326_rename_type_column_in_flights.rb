class RenameTypeColumnInFlights < ActiveRecord::Migration[8.0]
  def change
    rename_column :flights, :type, :flight_type
  end
end
