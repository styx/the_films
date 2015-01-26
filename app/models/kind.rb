# == Schema Information
#
# Table name: kinds
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string           not null
#  updated_at :datetime         not null
#

class Kind < ActiveRecord::Base
  has_many :films

  validates :name, uniqueness: true
end
