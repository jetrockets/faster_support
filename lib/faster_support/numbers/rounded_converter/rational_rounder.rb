# frozen_string_literal: true

require 'faster_support/numbers/rounded_converter/base_rounder'

module FasterSupport
  module Numbers
    class RoundedConverter < BaseConverter
      class RationalRounder < BaseRounder
        private

        def truncate(number, precision)
          if precision >= 0
            truncate_fraction(number, precision)
          else
            truncate_integer(number, precision)
          end
        end

        def truncate_integer(number, precision)
          number.to_i.round(precision)
        end

        # This method of finding the fraction part of
        # a rataional number becomes less effective as
        # the size of the denominator gets bigger.
        # In this case transforming to a decimal number
        # uses less memory.
        def truncate_fraction(number, precision)
          digits = number.numerator / number.denominator
          remainder = number.numerator % number.denominator

          dot_index = -1

          precision.times do
            break if remainder == 0

            digit = (10 * remainder) / number.denominator
            remainder = (10 * remainder) % number.denominator

            digits = digits * 10 + digit
            dot_index -= 1
          end

          if remainder * 10 / number.denominator >= 5
            digits += 1
          end

          string = String(digits)

          if dot_index != -1
            string.insert(dot_index, ".")
          end

          string
        end

        def adjust(number, precision, options)
          precision
        end

        def to_string(number, percision)
          String(number)
        end
      end
    end
  end
end
