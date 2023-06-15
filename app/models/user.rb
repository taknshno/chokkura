class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :favorite_spots, through: :favorites, source: :spot

  enum location:{
    "未設定":0,
    茨城県:1,栃木県:2,群馬県:3,埼玉県:4,千葉県:5,東京都:6,神奈川県:7
  }

end
