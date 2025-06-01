class Contact < ApplicationRecord
  validates :name, presence: true, length: { maximum: 40 }
  validates :email, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 2000 }
end
