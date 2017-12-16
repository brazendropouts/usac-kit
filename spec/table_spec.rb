require 'kit'

describe Kit::Table do

  def fixture_path(name)
    File.join('spec', 'fixtures', "#{name}.html")
  end

  def fixture(name)
    File.read(fixture_path(name))
  end

  it 'can be converted to HTML' do
    html = fixture('1917.full')
    table = Kit::Table.new(html)

    expect(table.to_html).to eql(fixture('1917.table'))
  end

  it 'iterates over race-result pairs' do
    html = fixture('1917.full')
    table = Kit::Table.new(html)

    race, result = table.to_a.first

    expect(race.text).to include('07/31/2011')
    expect(result.text).to include('DQ / 188')
  end

  it 'knows the column headings' do
    html = fixture('1917.full')
    table = Kit::Table.new(html)

    expect(table.headings).to eql(
      ['Place', 'Points', 'Name', 'USAC #', 'Time', 'Bib', 'Team']
    )
  end

end
