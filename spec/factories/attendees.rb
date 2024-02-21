FactoryBot.define do
  factory :attendee do
    sequence(:name) { |n| "Test Attendee #{n}" }
    # Ensure the phone number changes with each sequence.
    sequence(:phone_number) { |n| "123456789#{n % 10}" }
    sequence(:address) { |n| "#{n} Main St, City, Country" }
    # Ensure the credit card number changes with each sequence.
    sequence(:credit_card_info) { |n| "123456781234567#{n % 10}" }
    sequence(:email) { |n| "attendee#{n}@example.com" }
    password { "password" }
  end
end
