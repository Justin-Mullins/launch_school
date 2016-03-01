# exercise_.rb

hash1 = {a: 1, b: 2, c: 3, d: 4}
hash2 = {:cat => "whiskers",:dog => "snout",:bear => "claws"}

p hash1[:b]
puts ""

hash1[:e] = 5
p hash1
puts ""

hash1.delete_if {|key, value| value < 3.5 }
p hash1
