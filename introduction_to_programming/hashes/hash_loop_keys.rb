# hash_loop_keys.rb

def hash_loop_keys(hash)
  hash.each do |key, value|
    p key
  end
end

hash = { cat: 'whiskers', koala: 'paws', monkey: 'face' }
hash_loop_keys(hash)
