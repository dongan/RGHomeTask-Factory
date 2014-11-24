module MyFactoryModule
	class Factory
		def self.new(*method_names, &block)
			new_class = Class.new do
					
				method_names.each do |method_name|
					attr_accessor :"#{method_name}"
				end

				define_method :initialize do |*args|
					@inst_methods_values = []
					args.length.times do |i|
						send(:"#{method_names[i]}=", args[i])
						@inst_methods_values << args[i]
					end
				end

				define_method :[] do |arg|
					if (arg.instance_of?(Fixnum))
						raise IndexError.new if arg >= method_names.length || arg < 0
						@inst_methods_values[arg]
					else
						#raise NameError.new if TODO
						send(arg)  	
					end
				end

				define_method :[]= do |arg, value|
					if (arg.instance_of?(Fixnum))
						raise IndexError.new if arg >= method_names.length || arg < 0
						@inst_methods_values[arg] = value
					else
						#raise NameError.new if TODO
						send(:"#{arg}=", value)	
					end
				end

				block.call if block_given?

				define_method :== do |other_obj|
					method_names.each do |method|
						return false unless self.send(:"#{method}") == other_obj.send(:"#{method}")
				        return false unless self.class == other_obj.class
						return true
					end
				end

				define_method :each do |&block| 
					if block_given?
						method_names.each do |method|
							block.call method
						end
					else
						#TODO: return enumerator
					end
				end

				define_method :each_pair do |&block|
					if block_given?
						method_names.count.times do |i|
							block.call(method_names[i], @inst_methods_values[i])
						end
					else
						#TODO return enumerator
					end
				end

				define_method :length do 
					return method_names.length
				end

				alias_method :size, :length

				define_method :to_s do
					result_str = "<factory "
					
					method_names.count.times do |i|
						if @inst_methods_values[i].class == String
							result_str += " #{method_names[i]}=\"#{@inst_methods_values[i]}\""
						else
							result_str += " #{method_names[i]}=#{@inst_methods_values[i]}"
						end
					end
					result_str+=">"
					result_str
				end

				alias_method :inspect, :to_s

				define_method :members do
					method_names
				end

				define_method :to_a do
					@inst_methods_values
				end

				#TODO: define_method :hash
				#TODO: define method :to_h
				#TODO: define method :select
				#TODO: define method :values
				#TODO: define method :values_at

			end	
			new_class
		end
	end
end