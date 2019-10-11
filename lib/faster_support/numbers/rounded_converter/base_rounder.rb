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
          precision = precision(number, precision, options)

          string = to_string(number, precision, options)
          string = insignificant_zeros(string, precision, options)

          string
        end

        private

        # Precision

        def precision(number, options)
          return 0 if options[:precision] == 0

          if options[:significant]
            options[:precision] - decimal_places_count(number)
          else
            options[:precision]
          end
        end

        def decimal_places_count(number)
          return 1 if number.zero?

          Math.log10(number.abs).floor + 1
        end

        # Trailing zeros

        def insignificant_zeros(string, precision)
          return if options[:strip_insignificant_zeros]
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
