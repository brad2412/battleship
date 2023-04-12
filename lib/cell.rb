class Cell
  attr_reader :coordinate,
              :empty,
              :fired_upon
              
  attr_accessor :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @empty = true
    @fired_upon = false
  end

  def empty?
    @empty
  end

  def place_ship(ship)
    @ship = ship
    @empty = false
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if @empty == true
      @fired_upon = true
    elsif @empty == false
      self.ship.hit
      @fired_upon = true
    end
    
  end

  def render(display_s = false)
    if display_s && !@ship.nil? && fired_upon == false
      "S"
    elsif @empty == false && @fired_upon == true && ship.health == 0
      "X"
    elsif @empty == false && @fired_upon == true
      "H"
    elsif @fired_upon == false
      "."
    elsif @fired_upon == true
      "M"
    end
  end

end