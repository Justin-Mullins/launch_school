# while_loop.rb

x = "GO"
y = 0

while y != 1
  puts "Type \"STOP\" to quit."
  x = gets.chomp
  if x == "STOP"
    y = 1
  end
end
