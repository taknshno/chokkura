class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tagged_spots, through: :taggings, source: :spot

  validates :name, uniqueness: true
end
