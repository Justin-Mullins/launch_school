# exercise_5.rb

array = [1, 2, 3, 4, 5, 6, 7, 8 , 9, 10]
array.unshift(0)
array.push(11)
array.pop
array.push(3)
array.uniq!

array.each do |number|
  p number
end
