require 'rails_helper'

RSpec.describe Event, :type => :model do
  describe '#minute' do
    it 'returns a minute when the event occured on the first half of a match' do
      @event = FactoryGirl.create(:event, half: 1)
      expect(@event.minute).to eq(5)
    end

    it 'returns a minute when the event occured on the second half of a match' do
      @event = FactoryGirl.create(:event, half: 2)
      expect(@event.minute).to eq(50)
    end
  end
end
  