# frozen_string_literal: true

require_relative 'base_benchmark'

module NumberToCurrency
  class NUBenchmark < NumberToCurrency::BaseBenchmark
    def run
      puts 'ActiveSupport#number_to_currency VS FasterSupport#number_to_currency_u_n'.reverse_color

      setup_decimal
      profile_all

      setup_float
      profile_all
    end

    def currency_unit
      'RUB'
    end

    def a_s_call
      ActiveSupport::NumberHelper::NumberToCurrencyConverter.convert(number, unit: currency_unit, format: '%n %u')
    end

    def f_s_call
      FasterSupport::Numbers.number_to_currency_n_u(number, unit: currency_unit)
    end
  end
end

NumberToCurrency::NUBenchmark.new.run
