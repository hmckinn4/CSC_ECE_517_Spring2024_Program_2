class Review < ApplicationRecord
  belongs_to :attendee, optional: true
  belongs_to :event
  belongs_to :admin, optional: true

  # validations
  validates :event_id, presence: true
  validates :rating, presence: true
  validates :feedback, presence: true

end
