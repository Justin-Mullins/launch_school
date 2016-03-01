# ex2.rb

module Grill
  def grill(sound)
    puts "#{sound}"
  end
end

class HotDog
  include Grill
end

footlong = HotDog.new
footlong.grill("**sizzle**")
