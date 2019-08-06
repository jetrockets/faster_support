# frozen_string_literal: true

module FasterSupport
  module Numbers
    class RoundedConverter
      class BaseRounder
        def convert(number, options)
          precision = precision(number, options)

          number = truncate(number, precision)

          string = to_string(number, precision)
          string = add_trailing_zeros(string, precision)

          string
        end

        private

        def precision(number, options)
          if significant(number, options)
            precision(options) - integer_digits_count(number)
          else
            precision(options)
          end
        end

        def integer_digits_count(number)
          return 1 if number.zero?

          (Math.log10(number.abs) + 1).floor
        end

        def add_trailing_zeros(string, precision)
          dot_index = string.rindex(".")

          fraction_size = string.size - dot_index - 1
          zeros_to_add = precision - fraction_size

          zeros_to_add.times do
            string.insert(-1, "0")
          end

          string
        end
      end
    end
  end
end
