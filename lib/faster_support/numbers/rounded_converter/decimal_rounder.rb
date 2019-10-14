# frozen_string_literal: true

require 'faster_support/numbers/rounded_converter/base_rounder'

module FasterSupport
  module Numbers
    class RoundedConverter < BaseConverter
      class DecimalRounder < BaseRounder
        private

        def negative?(number)
          number.sign < 0
        end

        def round(number, options)
          number.round(precision(number, options))
        end

        def to_string(rounded, precision)
          if rounded.zero? || precision <= 0
            rounded.to_i.to_s
          else
            rounded.to_s("F")
          end
        end
      end
    end
  end
end
