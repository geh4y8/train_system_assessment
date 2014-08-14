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
end