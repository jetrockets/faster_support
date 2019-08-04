# frozen_string_literal: true

module FasterSupport
  module Numbers
    class DelimitedConverter
      def self.instance
        @instance ||= new
      end

      def convert(number, options)
      end

      def convert!(string, options)
      end
    end
  end
end
