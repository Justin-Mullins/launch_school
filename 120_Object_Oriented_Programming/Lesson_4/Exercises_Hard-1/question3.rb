# question3.rb

# Building on the prior vehicles question, we now must also
# track a basic motorboat. A motorboat has a single propeller
# and hull, but otherwise behaves similar to a catamaran.
# Therefore, creators of Motorboat instances don't need 
# to specify number of hulls or propellers. How would 
# you modify the vehicles code to incorporate a new 
# Motorboat class?

# =======++ ANSWER: ++======== #

module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Moveable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures along with
    super([20,20], 80, 8.0)
  end
end

class Catamaran
  include Moveable

  attr_accessor :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity

    # ... more code omitted.
  end
end

class Motorboat < Catamaran
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    # 1 propellor, 1 hull
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

car = Auto.new
puts car.tire_pressure(0)
puts car.range
cat = Catamaran.new(2, 2, 12, 100.0)
puts cat.range
boat = Motorboat.new(8, 40.0)
puts boat.range