# frozen_string_literal: true

require 'faster_support/numbers/currency_converter'

require 'faster_support/numbers/delimited_converter'
require 'faster_support/numbers/rounded_converter'

module FasterSupport
  module Numbers
    class << self
      def number_to_currency_u_n(amount, unit: '$', with_space: false)
        CurrencyConverter.instance.number_to_currency_u_n(amount, unit: unit, with_space: with_space)
      end

      def number_to_currency_n_u(amount, unit: 'RUB', with_space: true)
        CurrencyConverter.instance.number_to_currency_n_u(amount, unit: unit, with_space: with_space)
      end

      def number_to_delimited(number, options = {})
        DelimitedConverter.instance.convert(number, options)
      end

      def number_to_rounded(number, options = {})
        RoundedConverter.instance.convert(number, options)
      end
    end
  end
end
