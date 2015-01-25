class Genre < ActiveRecord::Base
  has_and_belongs_to_many :films

  validates :name, presence: true
end
