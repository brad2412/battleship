require './lib/ship'

RSpec.describe Ship do
  describe 'initialize' do
    it 'can initialize' do
      cruiser = Ship.new("Cruiser", 3)
      
      expect(cruiser.name).to eq("Cruiser")
      expect(cruiser.length).to eq(3)
      expect(cruiser.health).to eq(3)
    end
  end

  describe '#sunk?' do
    it 'has a sunk method' do
      cruiser = Ship.new("Cruiser", 3)

      expect(cruiser.sunk?).to eq(false)
    end
  end

  describe '#hit' do
    it 'has a hit method' do
      cruiser = Ship.new("Cruiser", 3)

      cruiser.hit
      expect(cruiser.health).to eq(2)
    end
  end

end