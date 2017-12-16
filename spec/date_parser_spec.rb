require 'kit'

describe Kit::DateParser do
  let(:row_class) { Struct.new(:text) }

  it 'does not parse empty strings' do
    row = row_class.new('')
    parser = Kit::DateParser.new

    expect(parser.parse(row)).to be_nil
  end

  it 'grabs the first date in a chunk of text' do
    row = row_class.new('snarfle 01/01/2014 02/02/2014')
    parser = Kit::DateParser.new

    expect(parser.parse(row)).to eql(Date.strptime('01/01/2014', '%m/%d/%Y'))
  end

  it 'will not grab incorrectly formatted dates' do
    row = row_class.new('snarfle 1-1-2014 2014-02-01')
    parser = Kit::DateParser.new

    expect(parser.parse(row)).to be_nil
  end

  it 'will skip bad formats' do
    row = row_class.new('snarfle 02-02-2014 01/01/2014')
    parser = Kit::DateParser.new

    expect(parser.parse(row)).to eql(Date.strptime('01/01/2014', '%m/%d/%Y'))
  end

  it 'will not parse invalid dates with the correct format' do
    row = row_class.new('snarfle 02/29/2014')
    parser = Kit::DateParser.new

    expect(parser.parse(row)).to be_nil
  end

  it 'seriously does not care if the whole thing is void of any date' do
    row = row_class.new('snarfle dorfle farfle')
    parser = Kit::DateParser.new

    expect(parser.parse(row)).to be_nil
  end

end
