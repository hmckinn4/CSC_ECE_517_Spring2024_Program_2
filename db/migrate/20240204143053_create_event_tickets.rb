class CreateEventTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :event_tickets do |t|
      t.references :attendee, null: true, foreign_key: true
      t.references :admin, null: true, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.string :confirmation_number

      t.timestamps
    end
  end
end
