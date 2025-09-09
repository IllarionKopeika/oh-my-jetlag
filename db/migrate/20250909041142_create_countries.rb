class CreateCountries < ActiveRecord::Migration[8.0]
  def change
    create_table :countries do |t|
      t.jsonb :name, null: false, default: {}
      t.string :code
      t.string :flag_url
      t.references :region, null: false, foreign_key: true

      t.timestamps
    end

    add_index :countries, :name, using: :gin
  end
end
