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

        # Round

        def round(number, options)
          precision = precision(number, options)

          if precision < 0
            round_integer(number, precision)
          else
            round_fraction(number, precision)
          end
        end

        def round_integer(number, precision)
          number = number.numerator * 10 / number.denominator

          number.round(precision - 1) / 10
        end

        def round_fraction(number, precision)
          multiplier = 10 ** (precision + 1)

          numerator = number.numerator * multiplier
          number = numerator / number.denominator

          number.round(-1) / 10
        end

        # To String

        def a(rounded, number, options)
          precision = precision(number, options)

          string = String(rounded)
          string = add_leading_zeros(string, precision)
          string = add_decimal_separator(string, precision)
          string = remove_truncating_zero(string, precision, options)
          string = process_trailing_zeros(string, precision, options)
          string = add_minus(string, number, rounded)

          string
        end

        def remove_truncating_zero(string, precision, options)
          return string unless options[:significant]
          return string if precision <= 0
          puts "!!!!!!!!"
          puts string
          puts options[:precision]
          puts string.size

          if options[:precision] == string.size - 2
            string.delete_suffix!("0")
            string.delete_suffix!(".")
          end

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

        # Trailing zeros

        def process_trailing_zeros(string, precision, options)
          if options[:strip_insignificant_zeros]
            remove_trailing_zeros(string, precision)
          end

          string
        end
      end
    end
  end
end
