# frozen_string_literal: true

require 'faster_support/numbers/currency_converter'

module FasterSupport
  module Numbers
    class << self
      def number_to_currency_u_n(amount, unit: '$', with_space: false)
        CurrencyConverter.instance.number_to_currency_u_n(amount, unit: unit, with_space: with_space)
      end

      def number_to_currency_n_u(amount, unit: 'RUB', with_space: true)
        CurrencyConverter.instance.number_to_currency_n_u(amount, unit: unit, with_space: with_space)
      end
    end
  end
end
