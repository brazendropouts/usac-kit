# Kit

Uniform and slim-fitting representation of USA Cycling race result tables.

## Usage

```ruby
client = Kit::Client.new
table = client.find(1917)
puts table.to_html
```
