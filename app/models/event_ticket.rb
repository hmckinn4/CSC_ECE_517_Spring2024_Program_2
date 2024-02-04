class EventTicket < ApplicationRecord
  belongs_to :attendee
  belongs_to :event
  belongs_to :room
end
