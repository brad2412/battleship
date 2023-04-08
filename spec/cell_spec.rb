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

  describe '#render' do
    it 'has a render method' do
      cell_1 = Cell.new("B4")
      expect(cell_1.render).to eq(".")

      cell_1.fire_upon
      expect(cell_1.render).to eq("M")

      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      
      cell_2.place_ship("Cruiser")
      expect(cell_2.render).to eq(".")
    end
  end
end