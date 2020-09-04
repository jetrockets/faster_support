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

## ActiveSupport Compatibility

Feature                     | Status
----------------------------|--------
number_to_currency          |
number_to_delimited         |


## Benchmarks

To run all suite of benchmarks use

``` bash
bundle exec ruby benchmarks/all.rb
```

You can also run every test separately

``` bash
bundle exec ruby benchmarks/number_to_currency/u_n_benchmark.rb
```

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

## Credits

Sponsored by [JetRockets](http://www.jetrockets.pro).

![JetRockets](https://media.jetrockets.pro/jetrockets-white.png)

Original idea by [@romul](https://github.com/romul) and [@Vankiru](https://github.com/Vankiru).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
