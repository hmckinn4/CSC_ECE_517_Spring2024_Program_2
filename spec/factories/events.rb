FactoryBot.define do
  factory :event do
    # Define attributes for event
    name { "HOCKEY" }
    start_time { Time.now }
    end_time { Time.now + 1.hour }
    room # Assumes that the Event belongs to a Room
    # Add additional event attributes as required
  end
end
