# frozen_string_literal: true

require 'faster_support/numbers/base_converter'

module FasterSupport
  module Numbers
    class DelimitedConverter < BaseConverter
      DEFAULTS = {
        separator: ".",
        delimiter: ","
      }

      def _convert(number, options)
        string = to_string(number, options)
        string = delimitize(string, options)

        string
      end

      private

      def to_string(number, options)
        string = String(number)

        dot_index = string.rindex(".")

        if dot_index
          string[dot_index] = separator(options)
        end

        string
      end

      def delimitize(string, options)
        first_digit_index = negative?(string) ? 1 : 0
        index = first_delimiter_position(string, options)

        while first_digit_index < index do
          string.insert(index, delimiter(options))
          index -= 3
        end

        string
      end

      def negative?(string)
        string.getbyte(0) == 45 # -
      end

      def first_delimiter_position(string, options)
        (string.rindex(separator(options)) || string.size) - 3
      end
    end
  end
end
