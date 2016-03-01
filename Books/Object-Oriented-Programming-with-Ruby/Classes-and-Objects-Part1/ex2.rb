# ex2.rb
# Create a class called MyCar.
# Add accessor method to MyCar to change
# and viewthe color of the car.

class MyCar
  attr_accessor :color, :speed
  attr_reader :year, :model

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
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

car = MyCar.new(16, 'black', 'Mustang')

puts car.speed
car.speed_up
puts car.speed
car.brake
puts car.speed
