class Board
  attr_reader :cells
              
  @@valid_cruiser_placements = [["A1", "A2", "A3"], ["A2", "A3", "A4"], ["B1", "B2", "B3"], ["B2", "B3", "B4"], ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"], ["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"], ["A4", "B4", "C4"], ["B1", "C1", "D1"], ["B2", "C2", "D2"], ["B3", "C3", "D3"], ["B4", "C4", "D4"]]
  @@valid_submarine_placements = [["A1", "A2"], ["A2", "A3"], ["A3", "A4"], ["B1", "B2"], ["B2", "B3"], ["B3", "B4"], ["C1", "C2"], ["C2", "C3"], ["C3", "C4"], ["D1", "D2"], ["D2", "D3"], ["D3", "D4"], ["A1", "B1"], ["B1", "C1"], ["C1", "D1"], ["A2", "B2"], ["B2", "C2"], ["C2", "D2"], ["A3", "B3"], ["B3", "C3"], ["C3", "D3"], ["A4", "B4"], ["B4", "C4"], ["C4", "D4"]]

  def initialize
      @cells = {
        "A1"  => Cell.new("A1"),
        "A2"  => Cell.new("A2"),
        "A3"  => Cell.new("A3"),
        "A4"  => Cell.new("A4"),
        "B1"  => Cell.new("B1"),
        "B2"  => Cell.new("B2"),
        "B3"  => Cell.new("B3"),
        "B4"  => Cell.new("B4"),
        "C1"  => Cell.new("C1"),
        "C2"  => Cell.new("C2"),
        "C3"  => Cell.new("C3"),
        "C4"  => Cell.new("C4"),
        "D1"  => Cell.new("D1"),
        "D2"  => Cell.new("D2"),
        "D3"  => Cell.new("D3"),
        "D4"  => Cell.new("D4")
      }
  end

  def valid_coordinate?(cell)
    if @cells.keys.include?(cell) 
      true
    else
      false
    end
  end

  def valid_placement?(ship, ship_location)
    if ship.name == "Cruiser"
      cruiser_validation(ship, ship_location)
    elsif ship.name == "Submarine"
      submarine_validation(ship, ship_location)
    end
  end

# helper methods

  def cruiser_validation(ship, ship_location)
    if ship.length != ship_location.length
      false
    elsif !@@valid_cruiser_placements.include?(ship_location)
      false
    else
      true
    end
  end

  def submarine_validation(ship, ship_location)
    if ship.length != ship_location.length
      false
    elsif  !@@valid_submarine_placements.include?(ship_location)
      false
    else
      true
    end
  end
end

#     