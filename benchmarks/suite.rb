# frozen_string_literal: true

require 'active_support'
require 'faster_support'
require 'benchmark/ips'
require 'memory_profiler'

require 'terminal-table'

class String
  def green;          "\e[32m#{self}\e[0m" end
  def reverse_color;  "\e[7m#{self}\e[27m" end
end

# Terminal::Table::Style.defaults = { border_top: false }
