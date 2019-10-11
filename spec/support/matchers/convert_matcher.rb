# frozen_string_literal: true

module FasterSupport
  module Matchers
    class ConvertMatcher
      attr_reader :number, :converter, :options, :value

      def initialize(number, options = {}, to = nil)
        @number = number; @options = options; @value = to
      end

      def with_converter(converter)
        @converter = converter; self
      end

      def with_options(options)
        @options = options || {}; self
      end

      def to(value)
        @value = value; self
      end

      def matches?(converter)
        with_converter(converter) && converted_correctly? && same_as_active_support?
      end

      def description
        "return the same value as ActiveSupport"
      end

      def failure_message
        if !converted_correctly?
          "expected to return #{value} but returned #{via_faster_support}"
        elsif !same_as_active_support?
          "expected to return the same value as ActiveSupport"
        end
      end

      private

      def converted_correctly?
        !value || via_faster_support == value
      end

      def same_as_active_support?
        via_faster_support == via_active_support
      end

      def via_faster_support
        @via_faster_support ||= FasterSupport::Numbers.send(converter, number, options)
      end

      def via_active_support
        @via_active_support ||= ActiveSupport::NumberHelper.send(converter, number, options)
      end
    end
  end
end
