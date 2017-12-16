# Kit

Uniform and slim-fitting representation of USA Cycling race result tables.

## Installation

```
gem install usac-kit
```

## Usage

```ruby
client = Kit::Client.new
usac_license_number = 358927
member = client.find(usac_license_number)

member.races # all races in which this member participated
most_recent = member.races.first

# Data available for each race
most_recent.member_name #=> "Kyle Russ"
most_recent.name #=> "2017 Illinois State Cyclocross Championships"
most_recent.result #=> "6 / 41"
most_recent.date #=> #<Date: 2017-12-03 ((2458091j,0s,0n),+0s,2299161j)>
most_recent.team_name # => "Brazen Dropouts Cycling Team"
```

- [YARD documentation](http://www.rubydoc.info/github/brazendropouts/usac-kit)
- ![Build Status](https://travis-ci.org/brazendropouts/usac-kit.svg?branch=master)
