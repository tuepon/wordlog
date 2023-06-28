class Word < ApplicationRecord
  validates :original, presence: true, length: { maximum: 100 }

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      word = find_by(id: row["id"]) || new
      word.attributes = row.to_hash.slice(*updatable_attributes)
      word.save
    end
  end

  def self.updatable_attributes
    ["id", "original", "translation", "description"]
  end
end