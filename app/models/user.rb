class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :username, presence: true, length: { maximum: 50 }

  has_many :words, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :images, dependent: :destroy
  has_one_attached :profile_pic
end
