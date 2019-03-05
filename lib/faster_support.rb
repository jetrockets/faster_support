# frozen_string_literal: true

require 'faster_support/numbers'
require 'faster_support/version'

class String
  def green;          "\e[32m#{self}\e[0m" end
  def reverse_color;  "\e[7m#{self}\e[27m" end
end
