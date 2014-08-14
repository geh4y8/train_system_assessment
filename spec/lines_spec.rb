require 'spec_helper'

describe Line do
  it 'initializes with a name' do
    new_line = Line.new({:name => 'US EXPRESS'})
    expect(new_line).to be_a Line
  end
end