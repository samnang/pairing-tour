require 'rubygems'
require 'spec'
require 'lib/sheet'

describe Sheet do
  
  it "should return empty for empty cell" do
    empty_cell_1 = "A1"
    empty_cell_2 = "ZX347"
    
    default_empty_cell_value = ""    
    sheet = Sheet.new
    
    value_1 = sheet.get empty_cell_1
    value_2 = sheet.get empty_cell_2
    
    value_1.should == default_empty_cell_value
    value_2.should == default_empty_cell_value
  end
end
