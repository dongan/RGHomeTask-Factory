require_relative 'factory.rb'
include MyFactoryModule

Obj = Factory.new(:first_name, :last_name) do
	public
	def greeting
		puts "greeting"
	end
end

other_obj = Obj.new("Denis", "Dvoryashin")

other_obj.first_name = "check 1"
puts other_obj.first_name
other_obj["first_name"] = "check 2"
puts other_obj["first_name"]
other_obj[:first_name] = "check 3"
puts other_obj[:first_name]
other_obj[0] = "check 4"
puts other_obj[0]
other_obj.greeting
