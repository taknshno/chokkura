class Spot < ApplicationRecord
  mount_uploaders :images, ImageUploader
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites, source: :user

  geocoded_by :name
  after_validation :geocode, if: :address_changed?

  enum area: { 県北: 1, 県央: 2, 県西: 3, 県南: 4, 鹿行: 5 }

  validates :name, presence: true, uniqueness: true
  validates :area, presence: true, length: { maximum: 10 }
  validates :address, presence: true, length: { maximum: 160 }
  validates :phone, length: { maximum: 21 }
  validates :holiday, length: { maximum: 10 }
  validates :sales_copy, length: { maximum: 255 }
  validates :detail_description, presence: true
  validates :simple_description, length: { maximum: 255 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  scope :area_search, -> (area){ where(area: area) }
  scope :tag_search, -> (tag_id){ where(id: Tagging.where(tag_id: tag_id).pluck(:spot_id)) }
end
