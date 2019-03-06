# frozen_string_literal: true

require_relative 'suite'

puts 'ActiveSupport#number_to_currency VS FasterSupport#number_to_currency_n_u'.reverse_color
puts "\nBigDecimal\n".green

float = rand * 10**(rand(12)) - 50_000_000
decimal = BigDecimal(float.to_s)

currency_unit = 'RUB'

Benchmark.ips do |x|
  x.report('ActiveSupport') { ActiveSupport::NumberHelper::NumberToCurrencyConverter.convert(decimal, unit: currency_unit, format: '%n %u') }
  x.report('FasterSupport') { FasterSupport::Numbers.number_to_currency_n_u(decimal, unit: currency_unit) }

  x.compare!
end

as_result = MemoryProfiler.report do
  100.times { ActiveSupport::NumberHelper::NumberToCurrencyConverter.convert(decimal, unit: currency_unit, format: '%n %u') }
end
fs_result = MemoryProfiler.report do
  100.times { FasterSupport::Numbers.number_to_currency_n_u(decimal, unit: currency_unit) }
end

table = Terminal::Table.new do |t|
  t.headings = ['Memory', 'Allocated', 'Retained']
  t.rows = [
    ['ActiveSupport', as_result.total_allocated_memsize, as_result.total_retained_memsize],
    ['FasterSupport', fs_result.total_allocated_memsize, fs_result.total_retained_memsize]
  ]
end

puts table
