class Sheet
  attr_accessor :cells
  
  DEFAULT_EMPTY_CELL_VALUE = ""
  
  def initialize
    @cells = {}
  end
  
  def get(cell)
    @cells[cell] || DEFAULT_EMPTY_CELL_VALUE
  end
  
  def put(cell, value)
    @cells[cell] = value
  end
end
