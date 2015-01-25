class CreateFilms < ActiveRecord::Migration
  def change
    create_table :films do |t|
      t.string :name, null: false
      t.string :second_name
      t.string :gapoif, null: false
      t.string :url, null: false
      t.integer :mins
      t.integer :year

      t.index :name
      t.index :second_name
      t.index :gapoif

      t.index :url, unique: true

      t.timestamps null: false
    end
  end
end
