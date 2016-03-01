# ex1.rb
# Create a superclass called Vehicle for the MyCar
# class to inherit from and move the behavior that 
# isn't specific to the MyCar classto the MyCar
# class. Create a constant in the MyCar class that
# stores information about the vehicle that makes
# it different from other types of vehicles. Then
# create a new class called MyTruck that inherits
# from the superclass that also has a constant
# defined that separates it from MyCar somehow.

class Vehicle
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon"
  end

  attr_accessor :color, :speed
  attr_reader :year, :model

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def spray_paint(c)
    self.color = c
  end

  # Speed up
  def speed_up
    self.speed += 30
  end

  # Slow down
  def brake
    self.speed -= 30
  end

  # Turn off
  def turn_off
    self.speed = 0
  end
end

class MyTruck < Vehicle
  BED_FULL = false

  def initialize(year, color, make)
    super(year, color, make)
  end

  def to_s
    "This truck is a #{color} #{year} #{model}."
  end
end

class MyCar < Vehicle
  TRUNK_FULL = false

  def initialize(year, color, make)
    super(year, color, make)
  end

  def to_s
    "This car is a #{color} #{year} #{model}."
  end
end

car = MyCar.new(2016, 'black', 'Challenger')
puts car
truck = MyTruck.new(2010, 'red', 'Silverado')
puts truck