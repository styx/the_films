class Film < ActiveRecord::Base
  belongs_to :kind
  has_and_belongs_to_many :genres

  validates :name, :gapoif, :url, presence: true
  validates :url, uniqueness: true
end
