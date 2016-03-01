# countdown_recursively

def countdown(number)
  if number == 1
    puts number
    puts "Done!"
  else
    puts number  
    countdown(number - 1)
  end
end

puts "What number to count down from?"
countdown(gets.chomp.to_i)
