# FasterSupport

ActiveSupport helpers done right

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'faster_support'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install faster_support

## Performance

```
ActiveSupport#number_to_currency VS FasterSupport#number_to_currency_u_n

Checking for BigDecimal
Warming up --------------------------------------
       ActiveSupport   874.000  i/100ms
       FasterSupport    30.613k i/100ms
Calculating -------------------------------------
       ActiveSupport      9.263k (± 5.2%) i/s -     46.322k in   5.015584s
       FasterSupport    386.647k (± 2.9%) i/s -      1.959M in   5.071773s

Comparison:
       FasterSupport:   386647.3 i/s
       ActiveSupport:     9262.8 i/s - 41.74x  slower

+---------------+-----------+----------+
| Memory        | Allocated | Retained |
+---------------+-----------+----------+
| ActiveSupport | 1016800   | 0        |
| FasterSupport | 13200     | 0        |
+---------------+-----------+----------+
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jetrockets/faster_support.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
