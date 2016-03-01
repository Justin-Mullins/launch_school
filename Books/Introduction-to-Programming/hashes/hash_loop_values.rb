# hash_loop_values.rb

def hash_loop_values(hash)
  hash.each do |key, value|
    p value
  end
end

hash = { cat: 'whiskers', koala: 'paws', monkey: 'face' }
hash_loop_values(hash)
