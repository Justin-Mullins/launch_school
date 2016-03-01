# ex6.rb
# Write a method called age that calls a private
# method to calculate the age of the vehicle. Make
# sure the private method is not available outside
# the class. You'll need to use Ruby's built in
# Time class to help.

module Haulable
  def haul
    puts "I'm Hauling!"
  end
end

class Vehicle
  attr_accessor :color, :speed 
  attr_reader :year, :model

  @@number_of_vehicles = 0

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
    @@number_of_vehicles += 1
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon"
  end

  def self.total_number_of_vehicles
    @@number_of_vehicles
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

  # Get age of Vehicle
  def get_age
    age_of_vehicle
  end

  # Private Methods
  private

  def age_of_vehicle
    t = Time.new
    t.year - self.year
  end
end

class MyTruck < Vehicle
  BED_FULL = false
  include Haulable

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

car = MyCar.new(2011, "white", "Civic")
truck = MyTruck.new(2005, "teal", "F250")
puts car.to_s
puts truck.to_s
puts "age of car: #{car.get_age} yrs old"
puts "age of truck: #{truck.get_age} yrs old"
