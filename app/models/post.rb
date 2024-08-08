class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  has_many :posts, dependent: :destroy
  has_many_attached :images

  attr_accessor :remove_image_ids

  before_save :purge_images, if: :remove_image_ids?

  private

  def purge_images
    images.where(id: remove_image_ids).each do |image|
      image.purge_later
    end
  end

  def remove_image_ids?
    remove_image_ids.present?
  end
end
