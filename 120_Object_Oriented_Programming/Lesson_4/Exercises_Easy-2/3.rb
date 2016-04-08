# 3.rb

# How do you find where Ruby will look for a method
# when that method is called?

# ANSWER:
# Method lookup path


# How can you find an object's ancestors?

# ANSWER:
# use the .ancestors method on the class to show it's
# lookup path

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

# What is the lookup chain for Orange and HotSauce?

# ANSWER:
puts "Orange Lookup Path"
puts Orange.ancestors
puts "HotSauce Lookup Path"
puts HotSauce.ancestors
