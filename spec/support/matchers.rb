# frozen_string_literal: true

require "support/matchers/convert_matcher"
require "support/matchers/convert_for_each_type_matcher"

module FasterSupport
  module Matchers
    def convert(number)
      ConvertMatcher.new(number)
    end

    def convert_for_each_type(number)
      ConvertForEachTypeMatcher.new(number)
    end
  end
end
