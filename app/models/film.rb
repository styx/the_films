# == Schema Information
#
# Table name: films
#
#  created_at  :datetime         not null
#  gapoif      :string           not null
#  id          :integer          not null, primary key
#  kind_id     :integer
#  mins        :integer
#  name        :string           not null
#  second_name :string
#  updated_at  :datetime         not null
#  url         :string           not null
#  year        :integer
#

class Film < ActiveRecord::Base
  belongs_to :kind

  has_many :film_genres
  has_many :genres, through: :film_genres

  validates :name, :gapoif, :url, presence: true
  validates :url, uniqueness: true

  searchkick
end
