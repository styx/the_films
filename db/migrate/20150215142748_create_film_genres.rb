class CreateFilmGenres < ActiveRecord::Migration
  def change
    create_table :film_genres do |t|
      t.belongs_to :film, index: true
      t.belongs_to :genre, index: true
      t.index [:film_id, :genre_id], unique: true
      t.index [:genre_id, :film_id], unique: true

      t.timestamps null: false
    end
    add_foreign_key :film_genres, :films
    add_foreign_key :film_genres, :genres

    drop_table :films_genres
  end
end
