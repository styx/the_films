# == Schema Information
#
# Table name: film_genres
#
#  created_at :datetime         not null
#  film_id    :integer
#  genre_id   :integer
#  id         :integer          not null, primary key
#  updated_at :datetime         not null
#

class FilmGenre < ActiveRecord::Base
  belongs_to :film, inverse_of: :film_genres
  belongs_to :genre, inverse_of: :film_genres

  validates :film, uniqueness: { scope: :genre }
end
