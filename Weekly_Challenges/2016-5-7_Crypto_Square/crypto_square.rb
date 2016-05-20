# crypto_square.rb
require 'pry'

class Crypto

  def initialize(phrase)
    @phrase = phrase
  end

  def size
    Math.sqrt(normalize_plaintext.length).ceil
  end

  def normalize_plaintext
    @phrase.downcase.gsub(/[^a-z0-9]/, '')
  end

  def plaintext_segments
    normal = normalize_plaintext
    array = []
    (size - 1).times do
      array << normal.slice!(0, size)
    end
    array
  end

  def ciphertext
    normal = normalize_plaintext
    square = []
    cipher = ''

    while normal != ''
      square << normal.slice!(0, size).split('')
    end
    
    square[0].size.times do |col|
      line = ''
      square.size.times do |row|
        break if square[row][col].nil?
        line << square[row][col]
      end
      # binding.pry
      cipher << line
    end
    cipher
  end

  def normalize_ciphertext
    normal = ciphertext
    index = size - 1
    index = size if Math.sqrt(ciphertext.length) < 2
    remainder = normal.size % size
    counter = remainder - 1

    (size - 1).times do
      normal.insert(index, ' ')
      if remainder == 0
        index += size
      elsif counter > 0 && remainder != 0
        index += size
        counter -= 1
      elsif counter == 0 && remainder != 0
        index += size - 1
      end
    end

    normal
  end
end
