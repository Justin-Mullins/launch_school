# ex2.rb

class Person
  attr_accessor :first_name, :last_name
  #attr_reader :name

  def initialize(name)
    @first_name = name
    @last_name = ''
  end

  def name
    @name = @first_name + ' ' + @last_name
  end
end

bob = Person.new('Robert')
puts bob.name                  # => 'Robert'
puts bob.first_name            # => 'Robert'
puts bob.last_name             # => ''
bob.last_name = 'Smith'
puts bob.name                  # => 'Robert Smith'