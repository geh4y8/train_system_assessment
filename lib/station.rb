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
end