# ex7.rb
# Create a class 'Student' with attributes name and
# grade. Do NOT make the grade getter public, so
# joe.grade will raise an error. Create a
# better_grade_than? method, that you can call.

class Person
  def initialize(name)
    @name = name
  end

  def show_hi
    hi
  end

  private

  def hi
    "Hi, I'm " + @name
  end
end

bob = Person.new("Robert P. Donahue, the third")
puts bob.show_hi