

require 'rails_helper'

RSpec.describe Room, type: :model do
  # Test to ensure the room availability scope works as intended.
  # Goal is that admin can't double-book rooms.
  describe '.available_for' do
    # Setting up a room and an event that's already booked.
    let!(:room) { create(:room) } # Assuming you've got FactoryBot set up for creating test instances.
    let!(:booked_event) do
      create(:event, room: room, start_time: '2024-02-12 14:00:00', end_time: '2024-02-12 16:00:00')
    end

    context 'when checking for booked slots' do
      it 'shouldn’t list rooms that are booked' do
        # If the scope works, it shouldn't find our room within the booked time.
        expect(Room.available_for(start: '2024-02-12 14:00:00', end: '2024-02-12 16:00:00')).to be_empty
      end
    end

    context 'when checking for free slots' do
      it 'should display rooms that are unbooked' do
        # This ensures un-booked rooms are visible show up.
        expect(Room.available_for(start: '2024-02-12 17:00:00', end: '2024-02-12 19:00:00')).to include(room)
      end
    end
  end
end
