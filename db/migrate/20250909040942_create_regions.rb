class CreateRegions < ActiveRecord::Migration[8.0]
  def change
    create_table :regions do |t|
      t.jsonb :name, null: false, default: {}
      t.references :continent, null: false, foreign_key: true

      t.timestamps
    end

    add_index :regions, :name, using: :gin
  end
end
