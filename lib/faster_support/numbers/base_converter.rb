# frozen_string_literal: true

module FasterSupport
  module Numbers
    class BaseConverter
      OPTIONS = %i(
        separator
        delimiter
        precision
        significant
        strip_insignificant_zeros
      ).freeze

      def self.instance
        @instance ||= new
      end

      def convert(number, options = {})
        #unless number?(number)
          #raise ArgumentError, "not a number"
        #end
        return number unless number?(number)

        if dup?(number, options)
          number = number.dup
        end

        _convert(number, options)
      end

      private

      def number?(number)
        Float(number)
      rescue ArgumentError, TypeError
        false
      end

      def dup?(number, options)
        #number.is_a?(String) && (!options[:dup] || number.frozen?)
        number.is_a?(String)
      end

      OPTIONS.each do |option|
        define_method option do |options|
          options[option] || self.class::DEFAULTS[option]
        end
      end
    end
  end
end
