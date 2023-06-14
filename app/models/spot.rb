class Spot < ApplicationRecord
  mount_uploaders :images, ImageUploader
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  enum area: { 県北: 1, 県央: 2, 県西: 3, 県南: 4, 鹿行: 5 }

  validates :name, presence: true, uniqueness: true
  validates :area, presence: true, length: { maximum: 10 }
  validates :address, presence: true, length: { maximum: 160 }
  validates :phone, length: { maximum: 21 }
  validates :holiday, length: { maximum: 10 }
  validates :sales_copy, length: { maximum: 255 }
  validates :detail_description, presence: true
  validates :simple_description, length: { maximum: 255 }
end
