class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      # Make attendee optional
      t.references :attendee, null: true, foreign_key: true
      t.references :event, null: false, foreign_key: true
      # Add admin and make it optional
      t.references :admin, null: true, foreign_key: true
      t.integer :rating
      t.text :feedback

      t.timestamps
    end
  end
end
