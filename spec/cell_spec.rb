require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  describe '#initialize' do
    it 'can initialize' do
      cell = Cell.new("B4")
      expect(cell).to be_a(Cell)
      
      expect(cell.coordinate).to eq("B4")
      expect(cell.ship).to eq(nil)
    end
  end

  describe '#empty' do
    it 'has an empty? method' do
      cell = Cell.new("B4")
      expect(cell.empty?).to eq(true)
    end
  end

  describe '#place_ship' do
    it 'has a place_ship method' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      
      cell.place_ship(cruiser)

      expect(cell.ship).to be_a(Ship)
      expect(cell.empty?).to be(false)
    end
  end

  describe '#fired_upon' do
    it 'has a fired_upon? method' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.fired_upon?).to eq(false)
      cell.fire_upon
      expect(cell.ship.health).to eq (2)
      expect(cell.fired_upon?).to eq(true)
    end
  end

end