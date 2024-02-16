class Review < ApplicationRecord
  belongs_to :attendee, optional: true
  belongs_to :event
  belongs_to :admin, optional: true
end
