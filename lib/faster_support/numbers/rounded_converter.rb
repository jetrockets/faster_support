# frozen_string_literal: true

require 'faster_support/numbers/base_converter'

require 'faster_support/numbers/rounded_converter/integer_rounder'
require 'faster_support/numbers/rounded_converter/integer_rounder'
require 'faster_support/numbers/rounded_converter/float_rounder'
require 'faster_support/numbers/rounded_converter/rational_rounder'
require 'faster_support/numbers/rounded_converter/decimal_rounder'

module FasterSupport
  module Numbers
    class RoundedConverter < BaseConverter
      DEFAULTS = {
        delimiter: ""
      }

      def _convert(number, options)
        string = to_string(number, options)
      end

      private

      def to_string(number, options)
        if number.is_a?(string)
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
    end
  end
end
