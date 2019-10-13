# frozen_string_literal: true

require 'faster_support/numbers/rounded_converter/base_rounder'

module FasterSupport
  module Numbers
    class RoundedConverter < BaseConverter
      class RationalRounder < BaseRounder
        private

        # Precision

        def negative?(number)
          (number.numerator > 0 && number.denominator < 0) ||
            (number.numerator < 0 && number.denominator > 0)
        end

        # Truncate

        def truncate(number, precision)
          if precision < 0
            truncate_integer(number, precision)
          else
            truncate_fraction(number, precision)
          end
        end

        def truncate_integer(number, precision)
          number = number.numerator * 10 / number.denominator

          number.round(precision - 1) / 10
        end

        def truncate_fraction(number, precision)
          multiplier = 10 ** (precision + 1)

          numerator = number.numerator * multiplier
          number = numerator / number.denominator

          number.round(-1) / 10
        end

        # To String

        def to_string(number, precision, options)
          string = String(number.abs)

          string = add_leading_zeros(string, precision)
          string = add_decimal_separator(string, precision)
          string = add_minus(number, string)

          string
        end

        def add_leading_zeros(string, precision)
          zeros = precision - string.size + 1

          zeros.times do
            string.insert(0, "0")
          end

          string
        end

        def add_decimal_separator(string, precision)
          return string if precision <= 0

          string.insert(-1 - precision, ".")
          string
        end

        def add_minus(number, string)
          string.insert(0, "-") if number < 0
          string
        end

        # Trailing zeros

        def trailing_zeros(string, precision, options)
          if options[:strip_insignificant_zeros]
            remove_trailing_zeros(string, precision)
          end

          if options[:significant]
            remove_truncating_zeros(string, precision, options)
          end

          string
        end
      end
    end
  end
end
