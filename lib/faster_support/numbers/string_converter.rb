# frozen_string_literal: true

require 'faster_support/numbers/base_converter'

module FasterSupport
  module Numbers
    class StringConverter < BaseConverter
      DEFAULTS = {}

      def convert(number, options)
        string = case number
                 when Integer    then integer_to_string(number, options)
                 when Float      then float_to_string(number, options)
                 when BigDecimal then decimal_to_string(number, options)
                 when Rational   then rational_to_string(number, options)
                 else 
                   raise ArgumentError.new("is not a number")
                 end

        unless strip_insignificant_zeros(options)
          string = add_trailing_zeros(string, options)
        end

        string
      end

      private

      def integer_to_string(number, options)
        String(number)
      end

      # It works incorrect with float numbers
      # that have more than 15 digits of its
      # integer part, because in this case
      # Float#round returns an incorrect value.
      def float_to_string(number, options)
        String(number.round(precision(options)))
        #sprintf(""%.#{precision}f", number.round(2))
      end

      def decimal_to_string(number, options)
        number.round(precision(options)).to_s("F")
      end

      # This method of finding the fraction part of
      # a rataional number becomes less effective as
      # the size of the denominator gets bigger.
      # In this case transforming to a decimal number
      # uses less memory.
      def rational_to_string(number, options)
        digits = number.numerator / number.denominator
        remainder = number.numerator % number.denominator

        dot_index = -1

        precision(options).times do
          break if remainder == 0

          anumber = remainder * 10

          digit = anumber / number.denominator
          remainder = anumber % number.denominator

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

      def add_trailing_zeros(string, options)
        dot_index = string.rindex(".")

        fraction_size = string.size - dot_index - 1
        zeros_to_add = precision(options) - fraction_size

        zeros_to_add.times do
          string.insert(-1, "0")
        end

        string
      end
    end
  end
end
