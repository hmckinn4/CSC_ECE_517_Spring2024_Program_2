require 'rails_helper'

RSpec.feature 'Creating an Event', type: :feature, js: true do
  # Tests the event creation process ensuring the room dropdown updates when we pick a date and time.
  scenario 'User selects date and time, available rooms update' do
    visit new_event_path
    # Filling in the form fields with JavaScript enabled
    fill_in 'Date', with: '2024-02-12'
    fill_in 'Start time', with: '14:00'
    fill_in 'End time', with: '16:00'
    # Initiates the change event to find only unbooked rooms using vanilla JavaScript.
    execute_script("document.querySelector('input#start_time').dispatchEvent(new Event('change'))")
    # Ensure the room selection dropdown updates accordingly
    # Replace `expected_count` with the number you test for
    expect(page).to have_selector('select#room_id option', count: expected_count)
    # Expected_count in the test depends on the total number of rooms
    # you have initially and the rooms that are booked.
    # If you have, say, 5 rooms in total and 1 room is booked for the mentioned slot,
    # the expected_count should be 4 (since 1 out of 5 rooms is unavailable, leaving 4 available).
  end
end
