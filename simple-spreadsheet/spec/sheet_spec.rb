require 'rubygems'
require 'spec'
require 'lib/sheet'

describe Sheet do
  
  it "should return empty for empty cell" do    
    empty_cells = ["A1", "ZX347"]
    
    verify_empty_cell_value(empty_cells[0])
    verify_empty_cell_value(empty_cells[1])
  end
  
  def verify_empty_cell_value(cell)
    default_empty_cell_value = ""
    sheet = Sheet.new
    
    value = sheet.get cell
      
    value.should == default_empty_cell_value
  end
end
