# queston7.rb

# What is used in this class but doesn't add any value?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a colour of green"
  end

end

#ANSWER:
# There is no need for the return in the self.information method.
# It works like that, but is redundant and works without it.

puts Light.information