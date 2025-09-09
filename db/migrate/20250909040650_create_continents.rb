class CreateContinents < ActiveRecord::Migration[8.0]
  def change
    create_table :continents do |t|
      t.jsonb :name, null: false, default: {}

      t.timestamps
    end

    add_index :continents, :name, using: :gin
  end
end
