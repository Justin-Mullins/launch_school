# exercise1.rb

words = ["laboratory", "experiment", "Pans", "Labyrinth", "elaborate", "polar bear"]

def has_lab?(words)
  words.each do |word|
    if word =~ /lab/
      puts "The word #{word} contains lab."
    end
  end
end

has_lab?(words)
