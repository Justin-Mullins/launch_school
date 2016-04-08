# 5.rb

# There are a number of variables listed below.
# What are the different types and how do you know which is which?

excited_dog = "excited dog"
@excited_dog = "excited dog"
@@excited_dog = "excited dog"

# ANSWER:
excited_dog = "excited dog"
# This is local variable. It has no symbols prepending the name
# of the variable.

@excited_dog = "excited dog"
# This is an instance variable. Each instance of an object that has
# instance variables, those values can be changed independantly 
# other instances of that object. You can tell it's an instance
# variable because it has a single @ symbol prepending it.

@@excited_dog = "excited dog"
# This is a class variable. Class variables are shared with all
# instances of a class and subclasses. YOu can tell it's a class
# variable because it has @@ symbols prepending it.