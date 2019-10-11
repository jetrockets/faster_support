# frozen_string_literal: true

require 'faster_support/numbers/rounded_converter/base_rounder'

module FasterSupport
  module Numbers
    class RoundedConverter < BaseConverter
      class RationalRounder < BaseRounder

        private
        
        # Decimal Places

        def decimal_places_count(number)
          if number <= -1 || number >= 1
            integer_decimal_places_count(number)
          else
            fraction_decimal_places_count(number)
          end
        end

        def integer_decimal_places_count(number)
          return 1 if number.zero?

          Math.log10(number.to_i.abs).floor + 1
        end

        def fraction_decimal_places_count(number)
          remainder = number.numerator % number.denominator
          return 0 if remainder.zero?

          1 - Math.log10((number.denominator / remainder).abs).floor
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

        # Adjust Precision

        def adjust(string, precision, options)
          if options[:significant]
            string.size + precision - options[:precision]
          else
            precision
          end
        end

        # To String

        def to_string(number, precision, options)
          string = String(number)

          add_leading_zeros(string, precision)
          remove_truncating_zeros(string, options)

          add_dot(string, precision)
          add_minus(string, number)

          string
        end

        def a(number)
          if number < 0 
            String(number.abs) 
          else
            String(number)
          end
        end

        def add_leading_zeros(string, precision)
          zeros = 1 + precision - string.size
          zeros = 1 + precision - digits_count(number, string)

          zeros.times do
            string.insert(0, "0")
          end
        end

        def remove_truncating_zeros(string, options)
          return unless options[:significant]
          zeros = options[:precision] - string.size

          zeros.times do
            string.delete_suffix!("0")
          end
        end

        def add_dot(string, precision)
          return string if precision <= 0

          dot_index = string.size - precision
          string.insert(dot_index, ".")
        end

        def digits_count(number, string)
          number < 0 ? string.size - 1 : string.size
        end

        def add_minus(string, number)
          string.insert(0, "-") if number < 0
        end

        # Remove Trailing Zeros

        def insignificant_zeros(string, precision)
          return string if precision <= 0

          while string.getbyte(-1) == 48 do
            string.delete_suffix!("0")
          end

          if string.getbyte(-1) == 46
            string.delete_suffix!(".")
          end

          string
        end
      end
    end
  end
end
