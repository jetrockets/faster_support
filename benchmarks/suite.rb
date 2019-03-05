# frozen_string_literal: true

require 'active_support'
require 'faster_support'
require 'benchmark/ips'
require 'memory_profiler'

require 'terminal-table'

Terminal::Table::Style.defaults = { border_top: false }
