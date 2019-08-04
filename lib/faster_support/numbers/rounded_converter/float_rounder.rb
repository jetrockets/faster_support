# frozen_string_literal: true

require 'faster_support/numbers/rounded_converter/base_rounder'

module FasterSupport
  module Numbers
    class RoundedConverter < BaseConverter
      class FloatRounder < BaseRounder
        private

        def negative?(number)
          number < 0
        end

        def round(number, options)
          number.round(precision(number, options))
        end

        # It works incorrect with float numbers
        # that have more than Float::DIG digits in 
        # its integer part.
        def to_string(number, precision)
          if number.zero? || precision <= 0
            String(number.to_i)
          else
            String(number)
          end

          #sprintf(""%.#{precision}f", number)
        end
      end
    end
  end
end
