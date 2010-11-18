module NaturalSort
	def natural_sort
		self.sort { |x, y|	
			convert_to_array_of_letters_and_numbers(x) <=> 
			convert_to_array_of_letters_and_numbers(y)
    }
	end
	
	def convert_to_array_of_letters_and_numbers(str)
		array = split_letters_and_numbers(str)
		
		convert_numeric_elements(array)
	end
	
	def convert_numeric_elements(array)
		1.step((array.size - 1), 2) do |index|
			array[index] = array[index].to_i
		end
		
		array
	end
	
	def split_letters_and_numbers(str)
		str.split(/(\d+)/)		
	end
end

class Array
	include NaturalSort	
end
