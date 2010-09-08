class Sheet
  attr_accessor :cells
  
  def initialize
    @cells = {}
  end
  
  def get(cell)
    @cells[cell] || ""
  end
  
  def put(cell, value)
    @cells[cell] = value
  end
end
