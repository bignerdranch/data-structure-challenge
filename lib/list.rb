require 'pry'

# Implement List here
class List
	attr_accessor :elements

	def initialize(args)
		@elements = args 
	end

	def self.[](*args)
		list = List.new(args)
		result = *(list.elements)
	end

	def [](*args)
		index = args.to_s.delete!('[]').to_i
		all_elements = *@elements
		all_elements[index]
	end

	def << *args
		if @elements
			@elements = @elements + args
		else
			@elements = args
		end
		self
	end

	def size
		if @elements
			all_elements = *@elements
			all_elements.count
		else
			0
		end
	end
end
