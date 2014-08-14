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

  def self.find_line(line_name)
    line = []
    results = DB.exec("SELECT * FROM lines WHERE name = '#{line_name}';")
    results.each do |result|
      line << Line.new({:name => result['name'], :id => result['id']})
    end
    line.first
  end

  def add_station(input_station_id)
    DB.exec("INSERT INTO stops (station_id, line_id) VALUES (#{input_station_id} , #{self.id});")
  end

  def self.line_list(input_station_id)
    lines = []
    results = DB.exec("SELECT lines.* FROM
              stations join stops on (stations.id = stops.station_id)
                join lines on (stops.line_id = lines.id)
              where stations.id = '#{input_station_id}';")
    results.each do |result|
      lines << Line.new({:id => result['id'], :name => result['name']})
    end
    lines
  end
end
end