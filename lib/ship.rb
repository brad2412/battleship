class Ship
  attr_reader :name,
              :length,
              :health,
              :sunk


  def initialize(name, length)
    @name = name
    @length = length
    @health = @length
    @sunk = false
  end

  def sunk?
    if self.health == 0
      @sunk = true
    end
    @sunk
  end

  def hit
    @health -= 1
  end

end