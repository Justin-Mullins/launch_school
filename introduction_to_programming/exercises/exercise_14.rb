# exercise_14.rb

contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

contact_types = [ :email, :addr, :phone ]
contact_counter = 0
contacts.each_key do |contact|
  type_counter = 0
  contact_types.each do |type|
    contacts[contact][type] = contact_data[contact_counter][type_counter]
    type_counter += 1
  end
  contact_counter += 1
end

p contacts
