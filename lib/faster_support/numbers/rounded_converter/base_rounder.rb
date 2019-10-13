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

          string = to_string(number, precision, options)
          string = trailing_zeros(string, precision, options)

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

          number = number.abs if negative?(number)
          Math.log10(number).floor + 1
        end

        # Trailing zeros

        def trailing_zeros(string, precision, options)
          if options[:strip_insignificant_zeros]
            remove_trailing_zeros(string, precision)
          else
            add_trailing_zeros(string, precision)
          end

          if options[:significant]
            remove_truncating_zeros(string, precision, options)
          end

          string
        end

        def add_trailing_zeros(string, precision)
          return if precision <= 0

          zeros = precision - string.size + dot_index(string) + 1

          zeros.times do
            string.insert(-1, "0")
          end
        end

        def dot_index(string)
          dot_index = string.rindex(".")

          unless dot_index
            string.insert(-1, ".")
          end

          dot_index || (string.size - 2)
        end

        def remove_trailing_zeros(string, precision)
          return if precision <= 0

          while string.getbyte(-1) == 48 do
            string.delete_suffix!("0")
          end

          if string.getbyte(-1) == 46
            string.delete_suffix!(".")
          end
        end

        # Truncating zeros

        def remove_truncating_zeros(string, precision, options)
          return if precision <= 0

          zeros = string.size - options[:precision] - 1
          zeros += 1 if string.getbyte(0) == '-'

          if zeros > 0
            string.delete_suffix!("0")
            string.delete_suffix!(".")
          end
        end
      end
    end
  end
end
