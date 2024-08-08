class Word < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  has_many :words, dependent: :destroy
  has_many_attached :images

  validates :title, presence: true, length: { maximum: 100 }

  def self.import(file, user)
    transaction do
      CSV.foreach(file.path, headers: true) do |row|
        word = user.words.find_or_initialize_by(title: row['title'])
        word.attributes = row.to_hash.slice(*updatable_attributes)
        raise ActiveRecord::Rollback, "Failed to save word: #{word.errors.full_messages.join(', ')}" unless word.save
      end
    end
  end

  def self.updatable_attributes
    %w[title translation description]
  end
end
