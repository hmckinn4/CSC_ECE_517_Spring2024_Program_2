class Event < ApplicationRecord
  belongs_to :room
  has_many :event_tickets
  has_many :reviews
  has_many :attendees, through: :event_tickets
end
