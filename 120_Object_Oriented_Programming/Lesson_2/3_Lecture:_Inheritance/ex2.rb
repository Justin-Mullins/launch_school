# ex2.rb
# Create a new class called Cat, which can do everything a
# dog can except swim or fetch. Assume the methods do the
# exact same thing.
module Swimmable
  def swim
    'swimming!'
  end
end

module Runnable
  def run
    'running!'
  end
end

module Jumpable
  def jump
    'jumping!'
  end
end

module Fetchable
  def fetch
    'fetching!'
  end
end

class Animal

end

class Cat < Animal
  include Runnable
  include Jumpable
  def speak
    'meow!'
  end
end

class Dog < Animal
  include Swimmable
  include Runnable
  include Jumpable
  include Fetchable
  def speak
    'bark!'
  end
end

class Bulldog < Dog
  def swim
    "Can't swim!"
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"
fatso = Bulldog.new
puts fatso.swim
boots = Cat.new
puts boots.run
puts boots.speak
