# frozen_string_literal: true

require 'faster_support/numbers/base_converter'

require 'faster_support/numbers/rounded_converter/integer_rounder'
require 'faster_support/numbers/rounded_converter/float_rounder'
require 'faster_support/numbers/rounded_converter/rational_rounder'
require 'faster_support/numbers/rounded_converter/decimal_rounder'

module FasterSupport
  module Numbers
    class RoundedConverter < BaseConverter
      self.namespace = :rounded

      def _convert(number, options)
        string = to_string(number, options)
        string = to_delimited(string, options)

        string
      end

      private

      def to_string(number, options)
        if number.is_a?(String)
          number = BigDecimal(number)
        end

        converter(number).instance.convert(number, options)
      end

      def converter(number)
        case number
        when Integer    then IntegerRounder
        when Float      then FloatRounder
        when Rational   then RationalRounder
        when BigDecimal then DecimalRounder
        end
      end

      def to_delimited(string, options)
        DelimitedConverter.instance._convert(string, options)
      end
    end
  end
end
