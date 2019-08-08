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
          string = to_string(number, precision)

          unless options[:strip_insignificant_zeros]
            string = add_trailing_zeros(string, precision)
          end

          string
        end

        private

        def precision(number, options)
          if options[:significant]
            options[:precision] - integer_part_size(number)
          else
            options[:precision]
          end
        end

        def integer_part_size(number)
          return 1 if number.zero?

          Math.log10(number.to_i.abs).floor + 1
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
