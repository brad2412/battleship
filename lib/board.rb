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
      cruiser_validation(ship, ship_location) && !overlap?(ship, ship_location)
    elsif ship.name == "Submarine"
      submarine_validation(ship, ship_location)  && !overlap?(ship, ship_location)
    end
  end

  def place(ship, ship_location)
    if ship.name == "Cruiser"
      cell_1 = self.cells[ship_location[0]]
      cell_1.ship = ship 
      cell_2 = self.cells[ship_location[1]]
      cell_2.ship = ship 
      cell_3 = self.cells[ship_location[2]]
      cell_3.ship = ship 
    elsif ship.name == "Submarine"
      cell_1 = self.cells[ship_location[0]]
      cell_1.ship = ship
      cell_2 = self.cells[ship_location[1]]
      cell_2.ship = ship
    end
  end

  def render(display_s = false)
    if !display_s
      p "  1 2 3 4 \n" +
        "A #{@cells["A1"].render} #{@cells["A2"].render} #{@cells["A3"].render} #{@cells["A4"].render} \n" +
        "B #{@cells["B1"].render} #{@cells["B2"].render} #{@cells["B3"].render} #{@cells["B4"].render} \n" +
        "C #{@cells["C1"].render} #{@cells["C2"].render} #{@cells["C3"].render} #{@cells["C4"].render} \n" +
        "D #{@cells["D1"].render} #{@cells["D2"].render} #{@cells["D3"].render} #{@cells["D4"].render} \n"
    elsif display_s
      p "  1 2 3 4 \n" +
        "A #{@cells["A1"].render(true)} #{@cells["A2"].render(true)} #{@cells["A3"].render(true)} #{@cells["A4"].render(true)} \n" +
        "B #{@cells["B1"].render(true)} #{@cells["B2"].render(true)} #{@cells["B3"].render(true)} #{@cells["B4"].render(true)} \n" +
        "C #{@cells["C1"].render(true)} #{@cells["C2"].render(true)} #{@cells["C3"].render(true)} #{@cells["C4"].render(true)} \n" +
        "D #{@cells["D1"].render(true)} #{@cells["D2"].render(true)} #{@cells["D3"].render(true)} #{@cells["D4"].render(true)} \n"
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

  def overlap?(ship, ship_location)
    ship_location.any? do |ship_location|
      @cells[ship_location].ship
    end
  end
end