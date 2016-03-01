# anagram.rb

def find_anagrams(words)
  result = {}
  words.each do |word|         # cycle through each word
    key = word.split('').sort.join # alphabetize letters
    if result.has_key?(key)    # if key exist
      result[key].push(word)   # append to values array
    else                       # key does not exist
      result[key] = [word]     # create new array with word in it
    end
  end
  p result
end

words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']

find_anagrams(words)
