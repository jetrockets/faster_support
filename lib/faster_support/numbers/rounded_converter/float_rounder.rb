# frozen_string_literal: true

require 'faster_support/numbers/rounded_converter/base_rounder'

module FasterSupport
  module Numbers
    class RoundedConverter < BaseConverter
      class FloatRounder < BaseRounder
        private

        def truncate(number, precision)
          number.round(precision)
        end

        # It works incorrect with float numbers
        # that have more than 15 digits of its
        # integer part, because in this case
        # Float#round returns an incorrect value.
        def to_string(number, precision)
          String(number)
          #sprintf(""%.#{precision}f", number)
        end
      end
    end
  end
end
