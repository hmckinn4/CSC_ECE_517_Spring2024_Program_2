class RenameAttendeeIdToUserIdInEventTickets < ActiveRecord::Migration[7.0]
  def change
    remove_reference :event_tickets, :attendee, index: true, foreign_key: true
    add_reference :event_tickets, :user, null: false, index: true, foreign_key: true
  end
end
