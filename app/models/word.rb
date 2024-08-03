class Word < ApplicationRecord
  belongs_to :user

  has_many_attached :images

  validates :title, presence: true, length: { maximum: 100 }

  def self.import(file, user)
    CSV.foreach(file.path, headers: true) do |row|
      word = user.words.find_or_initialize_by(id: row['id'])
      word.attributes = row.to_hash.slice(*updatable_attributes)
      word.user = user # ユーザーを関連付ける
      if word.save
        Rails.logger.info "Word #{word.title} saved successfully"
      else
        Rails.logger.error "Failed to save word: #{word.errors.full_messages.join(', ')}"
      end
    end
  end

  def self.updatable_attributes
    %w[id title translation]
  end
end
