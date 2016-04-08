# question2.rb

# Alyssa created the following code to keep track
# of items for a shopping cart application she's writing:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

# Alan looked at the code and spotted a mistake. 
# "This will fail when update_quantity is called", he says.

# Can you spot the mistake and how to address it?

#-----ANSWER-----:
# The mistake is that quantity doesn't have a set method,
# only a get method because it uses attr_reader
# quantity cannot be updated like that in the update_quantity
# method. To fix it, you would have to either put an @ sign
# at the beginning of quantity.
# Or you could change the attr_reader to attr_accessor
# so that quantity does have a setter method and can be called
# that way.

#TEST
new_invoice = InvoiceEntry.new("peanuts", 1)
puts new_invoice.quantity
new_invoice.update_quantity(3)
puts new_invoice.quantity
