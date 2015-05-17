require 'rails_helper'

RSpec.describe Player, :type => :model do
  describe '#height_in_feet' do
    it 'returns height in feet and inches' do
      @player = FactoryGirl.create(:player)

      expect(@player.height_in_feet).to eq("6 feet 2 inches")
    end
  end
end
  