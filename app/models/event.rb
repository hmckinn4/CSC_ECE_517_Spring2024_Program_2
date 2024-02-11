class Event < ApplicationRecord
  belongs_to :room
  has_many :event_tickets
  has_many :reviews
  has_many :attendees, through: :event_tickets
  scope :filter_by_upcoming, -> { where('date > ? OR (date = ? AND start_time > ?)', Date.today, Date.today, Time.zone.now) }

  def minus_seats_left
    self.seats_left -= 1
    save
  end

end
