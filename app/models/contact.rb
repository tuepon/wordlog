class Contact < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :body, presence: true, length: { maximum: 2000 }
end
