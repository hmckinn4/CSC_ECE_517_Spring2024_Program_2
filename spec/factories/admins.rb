FactoryBot.define do
  factory :admin do
    # Define the attributes for admin
    sequence(:email) { |n| "admin#{n}@example.com" }
    password { "admin123" }
    # Additional attributes below as needed
  end
end