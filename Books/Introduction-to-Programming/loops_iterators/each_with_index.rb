# each_with_index.rb

games = ["Symphony of the Night", "Lament of Innocence", "Aria of Sorrow", "Harmony of Despair"]

games.each_with_index do |game, index|
  puts "#{index}: #{game}"
end
