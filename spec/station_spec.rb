require 'spec_helper'

describe Station do
  it 'initializes with a name' do
    new_station = Station.new({:name => 'north'})
    expect(new_station).to be_a Station
  end
end