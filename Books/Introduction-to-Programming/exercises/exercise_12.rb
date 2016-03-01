# exercise_12.rb

contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

joe_info = {email: contact_data[0][0],
            addr: contact_data[0][1],
            phone: contact_data[0][2]
            }

sally_info = {email: contact_data[1][0],
              addr: contact_data[1][1],
              phone: contact_data[1][2]
              }

contacts["Joe Smith"] = joe_info
contacts["Sally Johnson"] = sally_info
p contacts

puts ""
puts "Joe's email is: #{contacts["Joe Smith"][:email]}"
