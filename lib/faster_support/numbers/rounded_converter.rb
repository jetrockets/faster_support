# frozen_string_literal: true

require 'faster_support/numbers/base_converter'

module FasterSupport
  module Numbers
    class RoundedConverter < BaseConverter
      DEFAULTS = {
        delimiter: ""
      }

      def _convert(number, options)
      end
    end
  end
end
