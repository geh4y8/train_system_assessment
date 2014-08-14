require 'spec_helper'

describe Line do
  it 'initializes with a name' do
    new_line = Line.new({:name => 'US EXPRESS'})
    expect(new_line).to be_a Line
  end
  
  it 'saves a line to the database' do
    new_line = Line.new({:name => 'US EXPRESS'})
    new_line.save
    expect(Line.all).to eq [new_line]
  end

  it 'lists all lines in the database' do
    new_line = Line.new({:name => 'US EXPRESS'})
    new_line.save
    new_line2 = Line.new({:name => 'CANADA EXPRESS'})
    new_line2.save
    expect(Line.all).to eq [new_line, new_line2]
  end

  it 'recognizes when two lines are equal' do
    new_line = Line.new({:name => 'US EXPRESS'})
    new_line.save
    new_line2 = Line.new({:name => 'US EXPRESS'})
    new_line2.save
    expect(new_line).to eq new_line2
  end
end