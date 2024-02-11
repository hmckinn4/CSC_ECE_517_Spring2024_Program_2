class Event < ApplicationRecord
  belongs_to :room
  has_many :event_tickets
  has_many :reviews
  has_many :attendees, through: :event_tickets
  scope :filter_by_upcoming, -> { where('date > ? OR (date = ? AND start_time > ?)', Date.today, Date.today, Time.zone.now) }
  scope :filter_by_availability, -> {where('seats_left > 0')}

  def minus_seats_left
    self.seats_left -= 1
    save
  end

  def add_seats_left
    self.seats_left += 1
    save
  end

end
