# frozen_string_literal: true

class FasterSupport
  def self.instance
    @instance ||= new
  end

  def initialize
    @zeros = {
      BigDecimal => 0.to_d,
      Rational => 0.to_r
    }
  end

  def number_to_currency(amount, unit:)
    # format BigDecimal as string to avoid a large string allocation
    # on contrary Rational has to be formatted as float
    format_string = amount.is_a?(BigDecimal) ? '%s'.freeze : '%.2f'.freeze

    # implicit round call, b/c of inconsistency of rounding rules in Ruby
    # https://bugs.ruby-lang.org/issues/12548
    str = sprintf(format_string, amount.round(2))

    # put the second zero after . if it is missing
    idx = str.rindex('.'.freeze)
    (3 - (str.length - idx)).times do
      str.insert(-1, '0'.freeze)
    end
    min_idx = (amount < zero(amount.class)) ? 1 : 0
    idx -= 3
    while idx > min_idx
      str.insert(idx, ','.freeze)
      idx -= 3
    end
    str.insert(min_idx, ' '.freeze)
    str.insert(min_idx, unit)
    str
  end

  private

  def zero(klass)
    @zeros[klass] || 0
  end
end
