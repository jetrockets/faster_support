# frozen_string_literal: true

module FasterSupport
  module Numbers
    class SignificantConverter < BaseConverter
      def convert(number, options)

        string = number.to_s("F")

        unless strip_insignificant_zeros(options)
          string = add_trailing_zeros(string, options)
        end
      end

      private

      def a(number, options)
        case number
        when Float, Rational
          BigDecimal(number, precision(options))
        when Integer, String
          truncate(BigDecimal(number), options)
        when BigDecimal
          truncate(number, options)
        else
          number
        end
      end

      def truncate(number, options)
        number.round(
          digits_count(number) - precision(options)
        )
      end

      def digits_count(number)
        return 1 if number.zero?

        (Math.log10(number.abs) + 1).floor
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
