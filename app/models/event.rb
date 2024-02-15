class Event < ApplicationRecord
  validates :start_time, presence: true
  belongs_to :room
  # Added dependent: :destroy here so that if an event is deleted,
  # so is the associated ticket and review with that event.
  has_many :event_tickets, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :attendees, through: :event_tickets
  # Scope for upcoming events
  scope :filter_by_upcoming, -> { where('date > ? OR (date = ? AND start_time > ?)', Date.today, Date.today, Time.zone.now) }
  # Scope for availability
  scope :filter_by_availability, -> {where('seats_left > 0')}

  # Scope for category
  scope :filter_by_category, ->(category) { where(category: category) if category.present? }

  # Scope for date
  scope :filter_by_date, ->(date) { where('date = ?', date) if date.present? }

  # Scope for price range
  scope :filter_by_price_range, ->(min_price, max_price) {
    where('ticket_price >= ? AND ticket_price <= ?', min_price, max_price) if min_price.present? && max_price.present?
  }

  # Scope for event name
  scope :filter_by_name, ->(name) { where('LOWER(name) = LOWER(?)', name) if name.present? }



  def minus_seats_left
    self.seats_left -= 1
    save
  end

  def add_seats_left
    self.seats_left += 1
    save
  end

end
