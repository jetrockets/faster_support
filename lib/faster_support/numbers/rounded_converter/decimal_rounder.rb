# frozen_string_literal: true

require 'faster_support/numbers/rounded_converter/base_rounder'

module FasterSupport
  module Numbers
    class RoundedConverter < BaseConverter
      class DecimalRounder < BaseRounder
        private

        def truncate(number, precision)
          number.round(precision)
        end

        def to_string(number, precision)
          if precision > 0
            number.to_s("F")
          else
            number.to_i.to_s
          end
        end
      end
    end
  end
end
