# question6.rb

# If we have these two methods:

# class Computer
#   attr_accessor :template

#   def create_template
#     @template = "template 14231"
#   end

#   def show_template
#     template
#   end
# end

#and

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

# What is the difference in the way the code works?

# -----ANSWER--------
# There is no difference, self is not needed 

#--------TEST--------
computer = Computer.new
computer.create_template
puts computer.show_template