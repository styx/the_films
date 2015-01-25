class CreateKinds < ActiveRecord::Migration
  def change
    create_table :kinds do |t|
      t.string :name, null: false

      t.timestamps null: false

      t.index :name, unique: true
    end

    change_table :films do |t|
      t.references :kind, index: true
    end

    add_foreign_key :films, :kinds
  end
end
