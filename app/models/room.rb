class Room < ApplicationRecord
  has_many :events

  # Add validations
  validates :address, presence: true
  validates :capacity, presence: true, numericality: { greater_than_or_equal_to: 1 }

  # Scope to filter rooms based on availability
  def self.available_for(time_range)
    where.not(id: Event.where.not(end_time: nil).where('(? BETWEEN start_time AND end_time) OR (? BETWEEN start_time AND end_time)', time_range[:start], time_range[:end]).select(:room_id))
  end
end
