# exercise_16.rb

a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']

a.map! { |phrase| phrase.split(" ") }
a.flatten!

p a
