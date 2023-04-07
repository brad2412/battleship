require './lib/ship'

RSpec.describe Ship do
  describe 'initialize' do
    it 'can initialize' do
      cruiser = Ship.new("Cruiser", 3)
      
      expect(cruiser.name).to eq("Cruiser")
      expect(cruiser.length).to eq(3)
    end
  end
end