class Line

  attr_accessor :name, :id

  def initialize(line_info)
    @name = line_info[:name]
    @id = line_info[:id]
  end

  def save
    result = DB.exec("INSERT INTO lines (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def self.all
    lines =[]
    results = DB.exec("SELECT * FROM lines;")
    results.each do |result|
      lines<< Line.new({:name => result['name'], :id => result['id']})
    end
    lines
  end

  def ==(another_line)
    self.name == another_line.name
  end
end