# 1.rb

# You are given the following code:

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

# What is the result of calling

oracle = Oracle.new
puts oracle.predict_the_future

# ANSWER:
# calling the predict_the_future method from the Oracle class
# will return 
#"You will " + choices.sample

# the choices method just has an array with 3 strings in it.
# So, calling choices.sample will randomly return one of the strings

