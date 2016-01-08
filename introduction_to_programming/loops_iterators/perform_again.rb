# perform_again.rb

loop do
  puts "Do you want to hear that again?"
  answer = gets.chomp
  if answer != 'Y' && answer != 'y'
    break
  end
end
