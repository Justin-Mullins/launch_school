# question5.rb

# If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# What would happen if I called the methods
# like shown below?

#ANSWER:
tv = Television.new # a new instance of the TV class is created
tv.manufacturer # this would result in an error because 
                # this method is a class method.
tv.model # This works because this is not a class method

Television.manufacturer # this is the correct way to call a
                        # a class method
Television.model # This will not work, only class methods
                  # can be called this way.
