class ChangeColumnsTypeInFlights < ActiveRecord::Migration[8.0]
  def change
    remove_column :flights, :departure_local, :datetime
    remove_column :flights, :arrival_local, :datetime

    add_column :flights, :departure_local, :string
    add_column :flights, :arrival_local, :string
  end
end
