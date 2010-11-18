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
  
  Test_Data = {
								["a10", "a2"] => ["a2", "a10"],
								["a2a", "a1b"] => ["a1b", "a2a"],
								["alpha 2", "alpha 10", "alpha 1"] => ["alpha 1", "alpha 2", "alpha 10"]
							}
  
  Test_Data.each do |input, expected_result|
  	it "should order [#{input.join(', ')}]" do
  		result = input.natural_sort
  		
  		result.should == expected_result
  	end
  end
    
end

describe "Spikes" do
	it "should compare correctly between to arrays" do
		array1 = ['a', 2, 'b']
		array2 = ['a', 10]
		
		(array1 <=> array2).should == -1
	end
end




