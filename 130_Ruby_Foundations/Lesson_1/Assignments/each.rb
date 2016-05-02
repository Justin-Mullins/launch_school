# method implementation
def each(array)
  counter = 0
  while counter < array.length do
    yield(array[counter])
    counter += 1
  end

  array
end

array = ['Tom', 'Marvolo', 'Riddle', 1, 33, 445]
# method invocation
each(array) do |num|
  puts num
end