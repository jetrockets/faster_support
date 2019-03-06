# frozen_string_literal: true

require_relative 'suite'

class NumberToCurrencyUNBenchmark
  def run
    puts 'ActiveSupport#number_to_currency VS FasterSupport#number_to_currency_u_n'.reverse_color
    puts "\nBigDecimal\n".green
    profile_time
    results = profile_memory
    print_memory_results(results)
  end

  def number
    return @number if defined?(@number)

    float = rand * 10**(rand(12)) - 50_000_000
    @number = BigDecimal(float.to_s)
  end

  def currency_unit
    '$'
  end

  def profile_time
    Benchmark.ips do |x|
      x.report('ActiveSupport') { ActiveSupport::NumberHelper::NumberToCurrencyConverter.convert(number, unit: currency_unit, format: '%u %n') }
      x.report('FasterSupport') { FasterSupport::Numbers.number_to_currency_u_n(number, unit: currency_unit) }

      x.compare!
    end
  end

  def profile_memory
    as_result = MemoryProfiler.report do
      100.times { ActiveSupport::NumberHelper::NumberToCurrencyConverter.convert(number, unit: currency_unit, format: '%u %n') }
    end
    fs_result = MemoryProfiler.report do
      100.times { FasterSupport::Numbers.number_to_currency_u_n(number, unit: currency_unit) }
    end

    [as_result, fs_result]
  end

  def print_memory_results(results)
    table = Terminal::Table.new do |t|
      t.headings = ['Memory', 'Allocated', 'Retained']
      t.rows = [
        ['ActiveSupport', results[0].total_allocated_memsize, results[0].total_retained_memsize],
        ['FasterSupport', results[1].total_allocated_memsize, results[1].total_retained_memsize]
      ]
    end

    table.align_column(1, :right)
    table.align_column(2, :right)

    puts table
  end
end

NumberToCurrencyUNBenchmark.new.run
