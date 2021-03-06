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
  has_many :films, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true

  default_scope { order(:id) }
end
