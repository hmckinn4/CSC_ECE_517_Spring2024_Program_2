class EventTicket < ApplicationRecord
  belongs_to :attendee, optional: true
  belongs_to :event
  belongs_to :room
  belongs_to :admin, optional: true
end
