# ex4.rb
# Add a class method to MyCar that calculates
# the gas mileage for any car.

class MyCar
  attr_accessor :color, :speed
  attr_reader :year, :model

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon"
  end

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end
  
  def spray_paint(c)
    self.color = c
  end
  
  # Speed up car
  def speed_up
    self.speed += 1
  end

  # Slow down car
  def brake
    self.speed -= 1
  end

  # Turn off car
  def turn_off
    self.speed = 0
  end
end

MyCar.gas_mileage(13, 351)
