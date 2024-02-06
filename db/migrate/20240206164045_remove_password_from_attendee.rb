class RemovePasswordFromAttendee < ActiveRecord::Migration[7.0]
  def change
    remove_column :attendees, :password, :string
  end
end
