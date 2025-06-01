class Contact < ApplicationRecord
  validates :name, presence: true, length: { maximum: 40 }
  validates :email, presence: true, length: { maximum: 100 }, email_format: true
  validates :telephone, length: { maximum: 11 }, numericality: { only_integer: true }
  validates :body, presence: true, length: { maximum: 2000 }
end
