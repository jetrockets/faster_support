# frozen_string_literal: true

module FasterSupport
  module Numbers
    class RoundedConverter
      class IntegerRounder < BaseRounder
        private

        def truncate(number, precision)
          number.round(precision)
        end

        def to_string(number, precision)
          String(number)
        end
      end
    end
  end
end
