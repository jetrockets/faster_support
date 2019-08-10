# frozen_string_literal: true

module FasterSupport
  module Numbers
    class RoundedConverter < BaseConverter
      class BaseRounder
        def self.instance
          @instance ||= new
        end

        def convert(number, options)
          precision = precision(number, options)

          number = truncate(number, precision)
          precision = adjust(number, precision, options)

          string = to_string(number, precision)

          unless options[:strip_insignificant_zeros]
            string = add_trailing_zeros(string, precision)
          end

          string
        end

        private

        def precision(number, options)
          return 0 if options[:precision] == 0

          if options[:significant]
            options[:precision] - integer_part_size(number)
          else
            options[:precision]
          end
        end

        def integer_part_size(number)
          return 1 if number.zero?

          Math.log10(number.abs).floor + 1
        end

        def adjust(number, precision, options)
          return precision unless options[:significant]
          return precision if precision <= 0

          digits_count = integer_part_size(number.to_i)

          if digits_count + precision == options[:precision] + 1
            precision - 1
          else
            precision
          end
        end

        def add_trailing_zeros(string, precision)
          return string if precision <= 0

          zeros_to_add(string, precision).times do
            string.insert(-1, "0")
          end

          string
        end

        def zeros_to_add(string, precision)
          precision - string.size + dot_index(string) + 1
        end

        def dot_index(string)
          dot_index = string.rindex(".")

          unless dot_index
            string.insert(-1, ".")
          end

          dot_index || (string.size - 2)
        end
      end
    end
  end
end
