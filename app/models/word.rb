class Word < ApplicationRecord
  validates :original, presence: true, length: { minimum: 1, maximum: 100 }
end