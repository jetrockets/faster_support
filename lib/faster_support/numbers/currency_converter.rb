# frozen_string_literal: true

require 'bigdecimal'

module FasterSupport
  module Numbers
    class CurrencyConverter
      def self.instance
        @instance ||= new
      end

      def initialize
        @zeros = {
          BigDecimal => BigDecimal(0),
          Rational => Rational(0, 1)
        }
      end

      def number_to_currency_u_n(amount, unit:, with_space:)
        str = number_to_string(amount)

        min_idx = (amount < zero(amount.class)) ? 1 : 0
        # 3 chars from the end to the dot and another 3 chars to the first delimeter position
        idx = str.length - 6
        while idx > min_idx
          str.insert(idx, ','.freeze)
          idx -= 3
        end
        str.insert(min_idx, ' '.freeze) if with_space
        str.insert(min_idx, unit)
        str
      end

      def number_to_currency_n_u(amount, unit:, with_space:)
        str = number_to_string(amount)

        min_idx = (amount < zero(amount.class)) ? 1 : 0
        # 3 chars from the end to the dot and another 3 chars to the first delimeter position
        idx = str.length - 6
        while idx > min_idx
          str.insert(idx, ','.freeze)
          idx -= 3
        end
        str.insert(str.length, unit)
        str.insert(str.length - unit.size, ' '.freeze) if with_space
        str
      end

    private

      def number_to_string(number)
        case number
          when Integer    then integer_to_string(number)
          when Float      then float_to_string(number)
          when Rational   then rational_to_string(number)
          when BigDecimal then decimal_to_string(number)
          else raise ArgumentError.new('amount should be numeric')
        end
      end

      def integer_to_string(amount)
        sprintf('%d.00'.freeze, amount)
      end

      # It works incorrect with float numbers
      # that have more than 15 digits
      # of its integer part.
      # Float#round can return incorrect value.
      def float_to_string(amount)
        sprintf('%.2f'.freeze, amount.round(2))
      end

      # format BigDecimal as string to avoid a large string allocation
      # implicit round call, b/c of inconsistency of rounding rules in Ruby
      # https://bugs.ruby-lang.org/issues/12548
      def decimal_to_string(amount)
        str = amount.round(2).to_s('F')
        # put the second zero after . if it is missing
        if str.rindex('.'.freeze) != str.length - 3
          str.insert(-1, '0'.freeze)
        end
        str
      end

      def rational_to_string(amount)
        int_part = amount.to_i
        frac3 = (amount.numerator % amount.denominator)*1000 / amount.denominator
        frac_part = frac3 / 10
        last_digit = frac3 % 10
        frac_part += 1 if last_digit >= 5
        if frac_part == 100
          int_part += 1
          frac_part = 0
        end
        sprintf('%d.%02d'.freeze, int_part, frac_part)
      end

      def zero(klass)
        @zeros[klass] || 0
      end
    end
  end
end
