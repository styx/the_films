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
  has_and_belongs_to_many :genres

  validates :name, :gapoif, :url, presence: true
  validates :url, uniqueness: true

  searchkick
end
