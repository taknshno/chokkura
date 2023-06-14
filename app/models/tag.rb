class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :spots, through: :taggings

  validates :name, uniqueness: true
end
