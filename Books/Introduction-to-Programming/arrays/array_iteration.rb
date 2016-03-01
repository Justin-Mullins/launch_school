# array_iteration.rb

def iterate_over_array(array)
  new_array = []
  x = 0
  array.each do |e| 
    new_array[x] = e + 2
    x += 1
  end
  return new_array
end

arr = [ 1, 2, 3, 4, 5, 6]
new_arr = iterate_over_array(arr)
p arr
p new_arr
