class Cell
  attr_reader :coordinate,
              :ship,
              :empty,
              :fired_upon
              
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

  def render
    if @fired_upon == false
      "."
    elsif @fired_upon == true
      "M"
    end
  end
end