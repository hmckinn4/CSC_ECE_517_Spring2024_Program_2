require 'rails_helper'

# Test suite for the Review model.
RSpec.describe Review, type: :model do
  # Test if a review optionally belongs to an attendee.
  it { should belong_to(:attendee).optional }

  # Test if a review must belong to an event.
  it { should belong_to(:event) }

  # Test if a review optionally belongs to an admin.
  it { should belong_to(:admin).optional }

end
