require 'rubygems'
require 'spec'
require 'lib/sheet'

describe Sheet do
    
  context "when empty cell" do
    it "should return default cell value" do    
      empty_cells = ["A1", "ZX347"]
      
      @sheet = Sheet.new
      
      verify_cell_value(empty_cells[0])
      verify_cell_value(empty_cells[1])
    end
  end

  context "when value stores in cell" do
    before do
      @sheet = Sheet.new
    end
    
    it "should return stored value" do
      cell = "A21"
      stored_value = "A string"
      
      verify_value_of_cell_is_stored(cell, stored_value)
    end
    
    it "should return reassigned value" do
      cell = "A21"
      stored_value = "A string"
      new_stored_value = "A different string"
            
      verify_value_of_cell_is_stored(cell, stored_value)
      verify_value_of_cell_is_stored(cell, new_stored_value)
    end
    
    def verify_value_of_cell_is_stored(cell, stored_value)      
      @sheet.put(cell, stored_value)
      
      verify_cell_value(cell, stored_value)
    end
  end
  
  def verify_cell_value(cell, expected_value = Sheet::DEFAULT_EMPTY_CELL_VALUE)    
    value = @sheet.get cell
      
    value.should == expected_value
  end
end
