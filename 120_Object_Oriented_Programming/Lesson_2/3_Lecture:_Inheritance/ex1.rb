# ex1.rb
# make a subclass of Bulldog that overrides the swim method
# to return 'Can't Swim'.

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
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