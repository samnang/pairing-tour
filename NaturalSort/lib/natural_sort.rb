module NaturalSort
	def natural_sort
		self.sort {|x, y| x.to_i <=> y.to_i }
	end
end

class Array
	include NaturalSort	
end
