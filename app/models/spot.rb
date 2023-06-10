class Spot < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :name, presence: true
  validates :area, presence: true, length: { maximum: 10 }
  validates :address, presence: true, length: { maximum: 160 }
  validates :phone, length: { maximum: 21 }
  validates :holiday, length: { maximum: 10 }
  validates :sales_copy, length: { maximum: 255 }
  validates :detail_description, presence: true
  validates :simple_description, length: { maximum: 255 }
end
