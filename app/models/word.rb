class Word < ApplicationRecord
  belongs_to :user

  has_many_attached :images

  validates :title, presence: true, length: { maximum: 100 }

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      word = find_by(title: row['title']) || new
      word.attributes = row.to_hash.slice(*updatable_attributes)
      Rails.logger.debug { "word: #{word.inspect}" }
      Rails.logger.debug { "word attributes: #{word.attributes}" }
      word.save
    end
  end

  def self.updatable_attributes
    %w[id title translation description]
  end
end
