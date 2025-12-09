class CreateUserFlights < ActiveRecord::Migration[8.0]
  def change
    create_table :user_flights do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :flight, null: false, foreign_key: true

      t.timestamps
    end

    add_index :user_flights, [ :user_id, :flight_id ], unique: true
  end
end
