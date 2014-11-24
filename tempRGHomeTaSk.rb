class Factory
		def self.new(first_name, last_name, &block)
			new_class = Class.new do
				block.call
			end	
			new_class
		end
end

Obj = Factory.new(:first_name, :last_name) do
	public
	def greeting
		puts "Hello world"
	end
end

other_obj = Obj.new

other_obj.greeting
