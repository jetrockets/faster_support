# frozen_string_literal: true

require "support/matchers/convert_matcher"
require "support/matchers/convert_for_types_matcher"

module FasterSupport
  module Matchers
    TYPES = {
      integer: [
        Integer,
        Float,
        Rational,
        BigDecimal,
        String
      ],

      fractional: [
        Float,
        Rational,
        BigDecimal,
        String
      ]
    }

    def convert(number)
      ConvertMatcher.new(number)
    end

    def convert_as_integer(number)
      convert_for_types(number.to_i, TYPES[:integer])
    end

    def convert_as_fractional(number)
      convert_for_types(number, TYPES[:fractional])
    end

    def convert_for_types(number, types)
      ConvertForTypesMatcher.new(number, types)
    end
  end
end
