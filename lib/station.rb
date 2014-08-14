class Station

  attr_accessor :name, :id

  def initialize(station_info)
    @name = station_info[:name]
    @id = station_info[:id]
  end
end