# has_value.rb

def has_value(hash, value)
  hash.has_value?(value)
end

hash = { 1 => "Stop!", 2 => "Drop!", 3 => "Roll!" }
value = "Pop!"

p has_value(hash, value)
