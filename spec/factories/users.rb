FactoryBot.define do
  factory :user do
    username { 'testuser' }
    sequence :email do |n|
      "test#{n}@example.com"
    end
    password { '123123' }
    password_confirmation { '123123' }
  end
end
