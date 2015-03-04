# == Schema Information
#
# Table name: genres
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string
#  updated_at :datetime         not null
#

class Genre < ActiveRecord::Base
  has_many :film_genres
  has_many :films, through: :film_genres, dependent: :restrict_with_exception

  validates :name, presence: true, uniqueness: true
end
