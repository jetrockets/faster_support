# frozen_string_literal: true

module FasterSupport
  module Numbers
    class RoundedConverter
      class DecimalRounder < BaseRounder
        def convert(number, options)
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

