require 'kit'

describe Kit::Client do

  it 'returns a table with some elements given a valid license number' do
    client = Kit::Client.new

    table = client.find(1917)

    expect(table.count > 0).to eql(true)
  end

  it 'returns a table with no elements given a person who has not raced' do
    client = Kit::Client.new

    table = client.find(1918)

    expect(table.none?).to eql(true)
  end

  it 'returns a table with no elements given a junk license number' do
    client = Kit::Client.new

    table = client.find('abcdef')

    expect(table.none?).to eql(true)
  end

  it 'returns a table with no elements given a non-existent license number' do
    client = Kit::Client.new

    table = client.find('1111111111')

    expect(table.none?).to eql(true)
  end

end
