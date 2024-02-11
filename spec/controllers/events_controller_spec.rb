
require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  # Testing our new action to make sure it's giving us the right rooms at the right times.
  describe 'GET #available_rooms' do
    let!(:room) { create(:room) }
    let!(:event) do
      create(:event, room: room, start_time: '2024-02-12 14:00:00', end_time: '2024-02-12 16:00:00')
    end

    it 'returns the correct rooms for a given time range' do
      # We're hitting the available_rooms path to see if it filters as we expect.
      get :available_rooms, params: { start_time: '2024-02-12 10:00:00', end_time: '2024-02-12 12:00:00', format: :json }
      expect(response).to be_successful
      # Expecting 1 room to be available since our test room is booked later in the day.
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end
end
