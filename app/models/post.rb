class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  has_many_attached :images
  validates :images, presence: false, blob: { content_type: :image }
  validates :caption, presence: true
  validates :body, presence: true

  attr_accessor :remove_image_ids

  before_save :purge_images, if: :remove_image_ids?

  private

  def purge_images
    images.attachments.where(id: remove_image_ids).find_each(&:purge_later)
  end

  def remove_image_ids?
    remove_image_ids.present?
  end
end
