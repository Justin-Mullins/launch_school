# optional_parameters.rb

def greeting(name, options = {})
  if options.empty?
    puts "Hi, my name is #{name}"
  else
    puts "Hi, my name is #{name}, I'm #{options[:age]}" +
      " years old and live in #{options[:city]}."
  end
end

greeting("Justin")
greeting("Justin", {age: 27, city: "Denton, Texas"})
