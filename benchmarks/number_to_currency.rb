# frozen_string_literal: true

require_relative 'suite'

@float_examples = (1..100_000).map{|_| rand * 10**(rand(12)) - 50_000_000 }
@int_examples = (1..100_000).map{|_| (rand(100_000_000) - 50_000_000)}
@decimal_examples = @float_examples.map{|x| BigDecimal(x.to_s)}
@rational_examples = @int_examples.map{|x| Rational(x, rand(10_000)+1)}

currency_unit = '$'
puts "\nBenchmark BigDecimal:"
Benchmark.ips do |x|
  x.report("number_to_currency AS:") { @decimal_examples.each {|amount| ActiveSupport::NumberHelper::NumberToCurrencyConverter.convert(amount, {}) } }
  x.report("number_to_currency FS:") { @decimal_examples.each {|amount| FasterSupport::Numbers.number_to_currency_u_n(amount) } }
end
