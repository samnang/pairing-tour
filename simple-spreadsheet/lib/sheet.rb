class Sheet
  attr_accessor :cells
  
  DEFAULT_EMPTY_CELL_VALUE = ""
  
  def initialize
    @cells = {}
  end
  
  def get(cell)
    value = get_cell_value(cell)
        
    if is_numeric?(value)
      return value.strip          
    end
    
    value
  end
  
  def put(cell, value)
    @cells[cell] = value
  end
  
  private  
  def is_numeric?(value)
    value.strip =~ /\d+$/
  end
  
  def get_cell_value(cell)
    @cells[cell] || DEFAULT_EMPTY_CELL_VALUE
  end
end
