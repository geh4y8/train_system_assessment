require 'spec_helper'

describe Station do
  it 'initializes with a name' do
    new_station = Station.new({:name => 'north'})
    expect(new_station).to be_a Station
  end

  it 'saves a line to the database' do
    new_station = Station.new({:name => 'north'})
    new_station.save
    expect(Station.all).to eq [new_station]
  end

  it 'lists all lines in the database' do
    new_station = Station.new({:name => 'north'})
    new_station.save
    new_station2 = Station.new({:name => 'south'})
    new_station2.save
    expect(Station.all).to eq [new_station, new_station2]
  end

  it 'recognizes when two lines are equal' do
    new_station = Station.new({:name => 'north'})
    new_station.save
    new_station2 = Station.new({:name => 'north'})
    new_station2.save
    expect(new_station).to eq new_station2
  end

  it 'lists all stops on a given line' do
    new_station = Station.new({:name => 'north'})
    new_station.save
    new_station2 = Station.new({:name => 'south'})
    new_station2.save
    new_line = Line.new({:name => 'US EXPRESS'})
    new_line.save
    new_station.add_line(new_line.id)
    new_station2.add_line(new_line.id)
    expect(Station.stop_list(new_line.id)).to eq [new_station, new_station2]
  end
end
