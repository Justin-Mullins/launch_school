# method implementation
def reduce(array, total = 0)
  counter = 0

  while counter < array.length do
    total = yield(total, array[counter])
    counter += 1
  end

  total
end

# method invocation
array = [1, 2, 3, 4, 5]
puts reduce(array) { |acc, num| acc + num }