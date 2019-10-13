# frozen_string_literal: true

require 'faster_support/numbers/rounded_converter/base_rounder'

module FasterSupport
  module Numbers
    class RoundedConverter < BaseConverter
      class IntegerRounder < BaseRounder
        private

        def negative?(number)
          number < 0
        end

        def truncate(number, precision)
          number.round(precision)
        end

        def to_string(number, precision, options)
          String(number)
        end
      end
    end
  end
end
