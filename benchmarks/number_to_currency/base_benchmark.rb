# frozen_string_literal: true

require_relative '../suite'

module NumberToCurrency
  class BaseBenchmark
    attr_reader :number

    def setup_decimal
      puts "\nBigDecimal\n".green

      float = rand * 10**(rand(12)) - 50_000_000
      @number = BigDecimal(float.to_s)
    end

    def setup_float
      puts "\nFloat\n".green

      @number = rand * 10**(rand(12)) - 50_000_000
    end

    def profile_time
      Benchmark.ips do |x|
        x.report('ActiveSupport') { a_s_call }
        x.report('FasterSupport') { f_s_call }

        x.compare!
      end
    end

    def profile_memory
      as_result = MemoryProfiler.report do
        100.times { a_s_call }
      end
      fs_result = MemoryProfiler.report do
        100.times { f_s_call }
      end

      print_memory_results([as_result, fs_result])
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
end
