# method implementation
def select(array)
  counter = 0
  new_array = []

  while counter < array.length do
    if yield(array[counter])
      new_array << array[counter]
    end
    counter += 1
  end

  new_array
end

# method invocation
array = [1, 2, 3, 4, 5]
puts select(array) { |num| num }