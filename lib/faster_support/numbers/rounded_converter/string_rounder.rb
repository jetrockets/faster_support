# frozen_string_literal: true

module FasterSupport
  module Numbers
    class RoundedConverter
      class StringRounder < BaseRounder
        private

        def integer_digits_count(string)
          dot_index = string.rindex(".") || 0

          dot_index - exponent(string)
        end

        def exponent(string)
          index = string.rindex("e") || string.rindex("E")
          return 0 unless index

          if string.getbyte(index + 1) == 45
            index += 1
          end

          string[index..-1].to_i
        end

        def truncate(string, precision)
          BigDecimal(string).round(precision)
        end

        def to_string(number, presicion)
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
