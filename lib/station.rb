class Station

  attr_accessor :name, :id

  def initialize(station_info)
    @name = station_info[:name]
    @id = station_info[:id]
  end

  def save
    result = DB.exec("INSERT INTO stations (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def self.all
    stations =[]
    results = DB.exec("SELECT * FROM stations;")
    results.each do |result|
      stations<< Station.new({:name => result['name'], :id => result['id']})
    end
    stations
  end

  def ==(another_station)
    self.name == another_station.name
  end

    def add_line(input_line_id)
    DB.exec("INSERT INTO stops (station_id, line_id) VALUES ('#{self.id}', '#{input_line_id}');")
  end

  def self.find_station(station_name)
    station = []
    results = DB.exec("SELECT * FROM stations WHERE name = '#{station_name}';")
    results.each do |result|
      station << Station.new({:name => result['name'], :id => result['id']})
    end
    station.first
  end

  def self.stop_list(line_id)
    stations = []
    results = DB.exec("SELECT stations.* FROM
              lines join stops on (lines.id = stops.line_id)
                join stations on (stops.station_id = stations.id)
              where lines.id = '#{line_id}';")
    results.each do |result|
      stations << Station.new({:id => result['id'], :name => result['name']})
    end
    stations
  end
end
