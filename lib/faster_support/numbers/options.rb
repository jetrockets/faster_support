# frozen_string_literal: true

module FasterSupport
  module Numbers
    class Options
      DEFAULTS = {
        delimited: {
          separator: ".",
          delimiter: ","
        },

        rounded: {
          separator: ".",
          delimiter: "",
          precision: 3,
          significant: false,
          strip_insignificant_zeros: false
        },

        currency: {
          format: "%u%n",
          negative_format: "-%u%n",
          unit: "$",
          separator: ".",
          delimiter: ",",
          precision: 2,
          significant: false,
          strip_insignificant_zeros: false
        },

        percentage: {
          format: "%n%",
          separator: ".",
          delimiter: "",
          precision: 3,
          significant: false,
          strip_insignificant_zeros: false
        }
      }

      def initialize(options, namespace)
        @options = options; @namespace = namespace
      end

      def [](key)
        @options[key] || locale[key] || defaults[key]
      end

      def defaults
        DEFAULTS[@namespace]
      end

      def locale
        {}
      end
    end
  end
end
