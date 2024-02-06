class RenameAttendeeIdToUserIdInReviews < ActiveRecord::Migration[7.0]
  def change
    # Check if the attendee_id column exists before attempting to remove it
    if column_exists?(:reviews, :attendee_id)
      remove_reference :reviews, :attendee, index: true, foreign_key: true
    end

    # Check if the user_id column does not exist before attempting to add it
    unless column_exists?(:reviews, :user_id)
      add_reference :reviews, :user, null: false, index: true, foreign_key: true
    end
  end
end
