# question7.rb

# How could you change the method name below so that
# the method name is more clear and less repetitive.

# class Light
#   attr_accessor :brightness, :color

#   def initialize(brightness, color)
#     @brightness = brightness
#     @color = color
#   end

#   def self.light_information
#     "I want to turn on the light with a brightness level of super high and a colour of green"
#   end

# end

# -----ANSWER:-------
# The class is already called Light, so the method should just
# be called information, not light_information.

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    "I want to turn on the light with a brightness level of super high and a colour of green"
  end

end