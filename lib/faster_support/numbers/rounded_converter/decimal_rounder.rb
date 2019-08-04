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

        def to_string(number, precision)
          if number.zero? || precision <= 0
            number.to_i.to_s
          else
            number.to_s("F")
          end
        end
      end
    end
  end
end
