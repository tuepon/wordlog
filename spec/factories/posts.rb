FactoryBot.define do
  factory :post do
    caption { "MyString" }
    user { nil }
    allow_comments { "MyString" }
    show_likes_count { false }
  end
end
