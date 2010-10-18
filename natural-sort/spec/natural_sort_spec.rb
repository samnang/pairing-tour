require 'rubygems'
require 'spec'
require 'lib/natural_sort'

describe NaturalSort do	
	it "should order correctly in numerics" do
		array = ["10", "2"]

		result = array.natural_sort 

		result.should == ["2", "10"]
	end

  it "should order letter correctly" do
    array = %w{banana apple grape orange mango}

    result = array.natural_sort

    result.should == ["apple", "banana", "grape", "mango", "orange"]
  end
	
	it "should order letter followed by numeric" 
    
end


