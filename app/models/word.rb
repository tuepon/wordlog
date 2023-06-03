class Word < ApplicationRecord
  validates :original, presence: true, length: { minimum: 1, maximum: 100 }
  validates :translation, presence: true, length: { minimum: 1, maximum: 200 }
  validates :description, presence: true, length: { maximum: 300 }
end