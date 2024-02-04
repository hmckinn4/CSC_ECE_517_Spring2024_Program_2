class CreateAttendees < ActiveRecord::Migration[7.0]
  def change
    create_table :attendees do |t|
      t.string :email
      t.string :password
      t.string :name
      t.string :phone_number
      t.text :address
      t.string :credit_card_info

      t.timestamps
    end
  end
end
