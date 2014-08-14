class Line

  attr_accessor :name, :id

  def initialize(line_info)
    @name = line_info[:name]
    @id = line_info[:id]
  end
end