require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @@valid_cruiser_placements = [["A1", "A2", "A3"], ["A2", "A3", "A4"], ["B1", "B2", "B3"], ["B2", "B3", "B4"], ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"], ["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"], ["A4", "B4", "C4"], ["B1", "C1", "D1"], ["B2", "C2", "D2"], ["B3", "C3", "D3"], ["B4", "C4", "D4"]]
    @@valid_submarine_placements = [["A1", "A2"], ["A2", "A3"], ["A3", "A4"], ["B1", "B2"], ["B2", "B3"], ["B3", "B4"], ["C1", "C2"], ["C2", "C3"], ["C3", "C4"], ["D1", "D2"], ["D2", "D3"], ["D3", "D4"], ["A1", "B1"], ["B1", "C1"], ["C1", "D1"], ["A2", "B2"], ["B2", "C2"], ["C2", "D2"], ["A3", "B3"], ["B3", "C3"], ["C3", "D3"], ["A4", "B4"], ["B4", "C4"], ["C4", "D4"]]
  end
  
  describe '#initialize' do
    it 'can initialize' do
      expect(@board).to be_a(Board)
      expect(@board.cells).to be_a(Hash)
      expect(@board.cells.length).to eq(16)
      expect(@board.cells.keys).to eq(["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"])
    end

    describe '#valid_coordinate?' do
      it 'has a valid coordinate method' do
        expect(@board.valid_coordinate?("A1")).to eq(true)
        expect(@board.valid_coordinate?("D4")).to eq(true)
        expect(@board.valid_coordinate?("A5")).to eq(false)
        expect(@board.valid_coordinate?("E1")).to eq(false)
        expect(@board.valid_coordinate?("A22")).to eq(false)
      end
    end

    describe '#valid_placement?' do
      it 'has a valid placement method that checks the length of the ship' do
        expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to eq(false)
        expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to eq(false)
      end

      it 'has a valid placement method that checks for valid consecutive coordinates' do
        expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to eq(false)
        expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to eq(false)
        expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to eq(false)
        expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to eq(false)
      end

      it 'has a valid placement method that does not allow diagonal coordinates' do
        expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to eq(false)
        expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to eq(false)
      end

      it 'has a valid placement method that allows for valid placement' do
        expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to eq(true)
        expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to eq(true)
      end

      it 'has a valid placement method that prevents overlapping' do
        @board.place(@cruiser, ["A1", "A2", "A3"])

        expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to eq (false)
      end
    end

      it 'has a #cruiser_validation helper method' do
        expect(@board.cruiser_validation(@cruiser, ["A1", "A2"])).to eq(false)
        expect(@board.cruiser_validation(@cruiser, ["A1", "A2", "A4"])).to eq(false)
        expect(@board.cruiser_validation(@cruiser, ["A1", "A2", "A3"])).to eq(true)
      end

      it 'has a #submarine_validation helper method' do
        expect(@board.submarine_validation(@submarine, ["A1", "A2", "A3"])).to eq(false)
        expect(@board.submarine_validation(@submarine, ["A1"])).to eq(false)
        expect(@board.submarine_validation(@submarine, ["A1", "A2"])).to eq(true)
      end

      it 'has a @@valid_cruiser_placement class variable' do
        cruiser_1 = @@valid_cruiser_placements.include?(["A1", "B1", "E1"])
        cruiser_2 = @@valid_cruiser_placements.include?(["A1", "B1", "C1"])
        expect(cruiser_1).to eq(false)
        expect(cruiser_2).to eq(true)
      end

      it 'has a @@valid_submarine_placement class variable' do
        submarine_1 = @@valid_submarine_placements.include?(["A1", "E1"])
        submarine_2 = @@valid_submarine_placements.include?(["A1", "B1"])
        expect(submarine_1).to eq(false)
        expect(submarine_2).to eq(true)
      end

    describe '#place' do
      it 'has a place method for placing ships' do
        @board.place(@cruiser, ["A1", "A2", "A3"])
        expect(cell_1 = @board.cells["A1"]).to be_a(Cell)
        expect(cell_2 = @board.cells["A2"]).to be_a(Cell)
        expect(cell_3 = @board.cells["A3"]).to be_a(Cell)
        
        expect(cell_1.ship).to be_a(Ship)
        expect(cell_2.ship).to be_a(Ship)
        expect(cell_3.ship).to be_a(Ship)

        expect(cell_3.ship == cell_2.ship).to eq(true)
      end
    end

    describe '#overlap?' do
      it 'has a method for detecting overlapped ships' do 
        expect(@board.overlap?(@cruiser, ["A1", "A2", "A3"])).to eq(false)
        @board.place(@cruiser, ["A1", "A2", "A3"])
        expect(@board.overlap?(@submarine, ["A2", "B2"])).to eq(true)
      end
    end

    describe '#render' do 
      it 'has a render method for printing the board' do
        @board.place(@cruiser, ["A1", "A2", "A3"])
        expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
        expect(@board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
      end

      it 'can render more than one ship at a time' do
        @board.place(@cruiser, ["A1", "A2", "A3"])
        expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
        expect(@board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")

        @board.place(@submarine, ["A4", "B4"])
        expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
        expect(@board.render(true)).to eq("  1 2 3 4 \nA S S S S \nB . . . S \nC . . . . \nD . . . . \n")
      end
    end
  end
end
