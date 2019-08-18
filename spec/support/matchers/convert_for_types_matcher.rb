# frozen_string_literal: true

module FasterSupport
  module Matchers
    class ConvertForTypesMatcher
      attr_reader :number, :converter, :options, :value, :types

      def initialize(number, types)
        @number = number; @types = types
      end

      def with_converter(converter)
        @converter = converter
      end

      def with_options(options)
        @option = options; self
      end

      def to(value)
        @value = value; self
      end

      def matches?(converter)
        with_converter(converter)

        matchers.all? do |matcher|
          matcher.matches?(converter)
        end
      end

      def description
        "returns the same value as ActiveSupport"
      end

      def failure_message
        failed = matchers.detect(&:failure_message)

        "#{failed.number.class}: #{failed.failure_message}"
      end

      private

      def matchers
        @matchers ||= types.map do |type|
          ConvertMatcher.new(to_type(type), options, value)
        end
      end

      def to_type(type)
        if type == Float
          Float(number)
        elsif type == Rational
          Rational(number.to_s)
        elsif type == BigDecimal
          BigDecimal(number.to_s)
        elsif type == String
          String(number)
        else
          number
        end
      end
    end
  end
end
