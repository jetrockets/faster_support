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

        def round(number, options)
          number.round(precision(number, options))
        end

        def to_string(number, precision)
          String(number)
        end
      end
    end
  end
end
