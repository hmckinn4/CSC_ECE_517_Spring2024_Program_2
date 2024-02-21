class AddBuyerTypeToEventTickets < ActiveRecord::Migration[7.0]
  def change
    add_reference :event_tickets, :buyer, polymorphic: true, null: true
  end
end
