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
      def decimal_to_string(amount)
        str = amount.to_s('F'.freeze)
        dot_idx = str.rindex('.'.freeze)
        frac_length = str.length - dot_idx - 1

        if frac_length == 1
          # put the second zero after . if there is only one
          str.insert(-1, '0'.freeze)
        elsif frac_length == 2
          str
        else
          round_string(str, dot_idx)
        end
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

      def round_string(str, dot_idx = nil)
        # do round manually to support rounding as in ActiveSupport
        # b/c of inconsistency of rounding rules in Ruby https://bugs.ruby-lang.org/issues/12548
        dot_idx ||= str.rindex('.'.freeze)
        if str.getbyte(dot_idx+3) >= 53 # '5'
          idx = dot_idx + 2
          while true do
            if idx < 0
              str.insert(0, '1'.freeze)
              dot_idx += 1
              break
            end
            code = str.getbyte(idx)
            case code
            when 57 # '9'
              str.setbyte(idx, 48) # '0'
              idx -= 1
            when 46 # '.'
              idx -= 1
            when 45 # '-'
              str.insert(1, '1'.freeze)
              dot_idx += 1
              break
            else
              str.setbyte(idx, code+1)
              break
            end
          end
        end
        str[0, dot_idx+3]
      end

      def zero(klass)
        @zeros[klass] || 0
      end
    end
  end
end
