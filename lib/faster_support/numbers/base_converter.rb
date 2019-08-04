# frozen_string_literal: true

module FasterSupport
  module Numbers
    class BaseConverter
      def self.instance
        @instance ||= new
      end

      def self.namespace=(value)
        @namespace = value
      end

      def self.namespace
        @namespace
      end

      def convert(number, options = {})
        #unless number?(number)
          #raise ArgumentError, "not a number"
        #end
        return number unless number?(number)

        if number.is_a?(String)
          number = number.dup
        end

        _convert(number, Options.new(options, self.class.namespace))
      end

      private

      def number?(number)
        Float(number)
      rescue ArgumentError, TypeError
        false
      end
    end
  end
end
