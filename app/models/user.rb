class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: { maximum: 20 }

  has_many :words
  has_many :posts
  has_many :images
  has_one_attached :profile_pic
end
