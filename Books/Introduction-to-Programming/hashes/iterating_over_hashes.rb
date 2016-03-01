# iterating_over_hashes.rb

person = {name: 'bob', burger: 'yummy', weight: '160 lbs', hair: 'brown'}

person.each do |key, value|
  puts "Bob's #{key} is #{value}"
end
