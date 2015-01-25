class Kind < ActiveRecord::Base
  has_many :films

  validates :name, uniqueness: true
end
