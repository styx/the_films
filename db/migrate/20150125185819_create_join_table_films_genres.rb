class CreateJoinTableFilmsGenres < ActiveRecord::Migration
  def change
    create_join_table :films, :genres do |t|
      t.index [:film_id, :genre_id], unique: true
      t.index [:genre_id, :film_id], unique: true
    end

    add_foreign_key :films_genres, :films
    add_foreign_key :films_genres, :genres
  end
end
