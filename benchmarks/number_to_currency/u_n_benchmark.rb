# frozen_string_literal: true

require_relative 'base_benchmark'

module NumberToCurrency
  class UNBenchmark < NumberToCurrency::BaseBenchmark
    def run
      puts 'ActiveSupport#number_to_currency VS FasterSupport#number_to_currency_u_n'.reverse_color

      setup_decimal
      profile_time
      profile_memory

      setup_float
      profile_time
      profile_memory
    end

    def currency_unit
      '$'
    end

    def a_s_call
      ActiveSupport::NumberHelper::NumberToCurrencyConverter.convert(number, unit: currency_unit, format: '%u %n')
    end

    def f_s_call
      FasterSupport::Numbers.number_to_currency_u_n(number, unit: currency_unit)
    end
  end
end

NumberToCurrency::UNBenchmark.new.run
