# hash_loop.rb

def hash_loop(hash)
  hash.each do |key, value|
    puts "#{key}: #{value}"
  end
end

hash = { cat: 'whiskers', koala: 'paws', monkey: 'face' }
hash_loop(hash)
