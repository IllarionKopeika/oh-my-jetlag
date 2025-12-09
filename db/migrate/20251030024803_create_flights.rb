class CreateFlights < ActiveRecord::Migration[8.0]
  def change
    create_table :flights do |t|
      t.string :number
      t.datetime :departure_utc
      t.datetime :departure_local
      t.datetime :arrival_utc
      t.datetime :arrival_local
      t.integer :duration
      t.float :distance
      t.integer :status
      t.integer :type
      t.references :airline, null: false, foreign_key: true
      t.references :aircraft, null: false, foreign_key: true
      t.references :departure_airport, null: false, foreign_key: { to_table: :airports }
      t.references :arrival_airport, null: false, foreign_key: { to_table: :airports }

      t.timestamps
    end

    add_index :flights, [ :number, :departure_utc, :airline_id, :departure_airport_id, :arrival_airport_id ], unique: true
  end
end
