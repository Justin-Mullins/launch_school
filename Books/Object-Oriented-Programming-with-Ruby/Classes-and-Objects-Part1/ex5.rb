# ex5.rb
# Override the to_s method to create a user
# friendly print for the object.

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

  def to_s
    "This car is a #{year} #{model}. It's color is #{color}."
  end
end

car = MyCar.new(2016, 'black', 'Mustang')
puts car
