# frozen_string_literal: true
require 'rspec/expectations'

RSpec::Matchers.define :convert do |number|
  description do
    "returns the same value as ActiveSupport"
  end

  failure_message do |converter|
    if !correctly_converted?(converter, number)
      "expected to return #{value} but returned #{convert_by_faster(converter, number)}"
    elsif !same_as_active_support?(converter, number)
      "expected to return the same value as ActiveSupport"
    end
  end

  match do |converter|
    correctly_converted?(converter, number) &&
      same_as_active_support?(converter, number)
  end

  chain :with_options, :options
  chain :to, :value

  def correctly_converted?(converter, number)
    !value || convert_by_faster(converter, number) == value
  end

  def same_as_active_support?(converter, number)
    convert_by_faster(converter, number) == convert_by_active(converter, number)
  end

  def convert_by_faster(converter, number)
    FasterSupport::Numbers.send(converter, number, options || {})
  end

  def convert_by_active(converter, number)
    ActiveSupport::NumberHelper.send(converter, number, options || {})
  end
end
