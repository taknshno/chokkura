class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, password_length: 6..128

  before_update :not_change_last_admin
  before_destroy :not_delete_last_admin

  has_many :favorites, dependent: :destroy
  has_many :favorite_spots, through: :favorites, source: :spot

  validates :name, presence: true, length: { maximum: 60 }
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true

  enum location: {
    "未設定": 0,
    茨城県:1, 栃木県:2, 群馬県:3, 埼玉県:4, 千葉県:5, 東京都:6, 神奈川県:7
  }

  private

  def not_change_last_admin
    throw :abort if User.where(admin: true).count == 1 && self.will_save_change_to_admin?(from: true, to: false)
  end

  def not_delete_last_admin
    throw :abort if User.where(admin: true).count == 1 && self.admin == true
  end

  def self.common_guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name     = "guest"
    end
  end

  def self.admin_guest
    find_or_create_by!(email: "admin_guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name     = "guest(admin)"
      user.admin    = true
    end
  end
end
