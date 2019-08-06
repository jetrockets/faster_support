# frozen_string_literal: true

module FasterSupport
  module Numbers
    class RoundedConverter
      class RationalRounder < BaseRounder
        private

        def truncate(number, options)
        end

        # This method of finding the fraction part of
        # a rataional number becomes less effective as
        # the size of the denominator gets bigger.
        # In this case transforming to a decimal number
        # uses less memory.
        def rational_to_string(number, options)
          digits = number.numerator / number.denominator
          remainder = number.numerator % number.denominator

          dot_index = -1

          precision(options).times do
            break if remainder == 0

            anumber = remainder * 10

            digit = anumber / number.denominator
            remainder = anumber % number.denominator

            digits = digits * 10 + digit
            dot_index -= 1
          end

          if remainder * 10 / number.denominator >= 5
            digits += 1
          end

          string = String(digits)

          if dot_index != -1
            string.insert(dot_index, ".")
          end

          string
        end
      end
    end
  end
end
