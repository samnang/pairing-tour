module NaturalSort
	def natural_sort
		self.sort { |x, y| 
      if x.is_numeric? && y.is_numeric?
        x.to_i <=> y.to_i
      else
        x <=> y
      end
    }
	end

end

class Array
	include NaturalSort	
end

class String
  def is_numeric?
    self.to_i.to_s == self
  end
end
