FactoryBot.define do
  factory :review do
    attendee # Can belong to attendee
    admin # Can belong to admin
    event # Review belongs to an Event
    rating { 5 }
    feedback { "Had so much fun!" }
  end
end