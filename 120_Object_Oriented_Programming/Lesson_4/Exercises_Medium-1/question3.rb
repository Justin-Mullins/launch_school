# question3.rb

# In the last question Alyssa showed Alan this
# code which keeps track of items for a shopping cart application:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

# Alan noticed that this will fail when update_quantity
# is called. Since quantity is an instance variable, 
# it must be accessed with the @quantity notation when setting it.
# One way to fix this to change attr_reader to attr_accessor.

# Is there anything wrong with fixing it this way?

#----ANSWER:-----
# Changing the quantity to attr_accessor, to change the quantity
# you could use the setter method and it would circumvent the 
# safeguards programmed into the update_quantity method.