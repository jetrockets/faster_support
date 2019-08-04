# frozen_string_literal: true

module FasterSupport
  module Numbers
    class RoundedConverter < BaseConverter
      class BaseRounder
        def self.instance
          @instance ||= new
        end

        def convert(number, options)
          rounded = round(abs(number), options)

          assemble_string(number, rounded, options)
        end

        private

        def abs(number)
          negative?(number) ? number.abs : number
        end

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

          Math.log10(number).floor + 1
        end

        # String

        def assemble_string(number, rounded, options)
          precision = precision(rounded, options)

          string = to_string(rounded, precision)
          string = process_trailing_zeros(string, precision, options)
          string = add_minus(string, number, rounded)

          string
        end

        # Trailing zeros

        def process_trailing_zeros(string, precision, options)
          if options[:strip_insignificant_zeros]
            remove_trailing_zeros(string, precision)
          else
            add_trailing_zeros(string, precision)
          end
        end

        def add_trailing_zeros(string, precision)
          return string if precision <= 0

          zeros = precision - fraction_size(string)

          zeros.times do
            string.insert(-1, "0")
          end

          string
        end

        def fraction_size(string)
          dot_index = string.rindex(".")

          unless dot_index
            string.insert(-1, ".")
            dot_index = string.size - 1
          end

          string.size - dot_index - 1
        end

        def remove_trailing_zeros(string, precision)
          return string if precision <= 0

          while string.getbyte(-1) == 48 do
            string.delete_suffix!("0")
          end

          string.delete_suffix!(".")
          string
        end

        # Add Minus

        def add_minus(string, number, rounded)
          if negative?(number) && !rounded.zero?
            string.insert(0, "-") 
          end

          string
        end
      end
    end
  end
end
