class AddDataSourceToFlights < ActiveRecord::Migration[8.0]
  def change
    add_column :flights, :data_source, :integer
  end
end
