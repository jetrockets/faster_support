# frozen_string_literal: true

module FasterSupport
  module Numbers
    class SignificantConverter < BaseConverter
      def convert(number, options)
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

      private

      def truncate(number, options)
        number.round(
          digits_count(number) - precision(options)
        )
      end

      def digits_count(number)
        return 1 if number.zero?

        (Math.log10(number.abs) + 1).floor
      end
    end
  end
end
