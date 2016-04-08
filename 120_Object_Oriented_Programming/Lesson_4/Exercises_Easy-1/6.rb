# 6.rb
# What could we add to the class below to access
# the instance variable @volume?

class Cube
  def initialize(volume)
   @volume = volume
  end

  # Need to add in a get method to return the @volume
  def get_volume
    @volume
  end
end

cube = Cube.new(100)
puts cube.get_volume