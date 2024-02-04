class Attendee < ApplicationRecord
  has_many :event_tickets
  has_many :reviews
end
