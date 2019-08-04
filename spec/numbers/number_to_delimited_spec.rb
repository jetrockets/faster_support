# frozen_string_literal: true

require 'spec_helper'
require 'active_support/all'

require 'matchers/converter_matcher'

RSpec.describe "FasterSupport::Numbers.number_to_delimited" do
  describe "number" do
    context "when a number is passed" do
      context "with less than 3 digits in its integer part" do
        it do
          expect(:number_to_delimited).to convert(0).to("0")
        end
      end

      context "with 3 digits in its integer part" do
        it do
          expect(:number_to_delimited).to convert(123).to("123")
        end
      end

      context "with the number of digits in its integer part that is devisible by 3" do
        it do
          expect(:number_to_delimited).to convert(123_456).to("123,456")
        end
      end

      context "with the number of digits in its integer part that is not devisible by 3" do
        it do
          expect(:number_to_delimited).to convert(12_345_678).to("12,345,678")
        end
      end

      context "with less than 3 digits in its fractional part" do
        it do
          expect(:number_to_delimited).to convert(123_456.78).to("123,456.78")
        end
      end

      context "with 3 digits in its fractional part" do
        it do
          expect(:number_to_delimited).to convert(123_456.789).to("123,456.789")
        end
      end

      context "with the number of digits in its fractional part that is devisible by 3" do
        it do
          expect(:number_to_delimited).to convert(123_456.789012).to("123,456.789012")
        end
      end

      context "with the number of digits in its fractional part that is not devisible by 3" do
        it do
          expect(:number_to_delimited).to convert(123_456_789.78901).to("123,456,789.78901")
        end
      end

      context "with only fractional part" do
        it do
          expect(:number_to_delimited).to convert(0.78901).to("0.78901")
        end
      end

      context "that is negative" do
        it do
          expect(:number_to_delimited).to convert(-123_456).to("-123,456")
        end
      end
    end

    context "when a string is passed to" do
      context "which contains a positive number" do
        it do
          expect(:number_to_delimited).to convert("123456.78").to("123,456.78")
        end
      end

      context "which contains a negative number" do
        it do
          expect(:number_to_delimited).to convert("-123456.78").to("-123,456.78")
        end
      end

      context "which is html safe" do
        it do
          expect(:number_to_delimited).to convert("123456.78".html_safe).to("123,456.78")
        end
      end

      context "which contains no numbers" do
        it do
          expect(:number_to_delimited).to convert("This string does not contain any numbers")
                                            .to("This string does not contain any numbers")
        end
      end
    end

    context "when nil is passed to" do
      it do
        expect(:number_to_delimited).to convert(nil).to(nil)
      end
    end

    context "when an object that is not number or string is passed to" do
      it do
        expect(:number_to_delimited).to convert([1, 2, 3]).to([1, 2, 3])
      end
    end
  end

  describe "options" do
    context "when options contain :delimiter_pattern" do
      pending do
        expect(:number_to_delimited).to convert(123_456.78)
                                          .with_options(delimiter_pattern: /(\d+?)(?=(\d\d)+(\d)(?!\d))/)
                                          .to("1,23,456.78")
      end
    end

    context "when options contain :delimiter" do
      it do
        expect(:number_to_delimited).to convert(12_345_678)
                                          .with_options(delimiter: " ")
                                          .to("12 345 678")
      end
    end

    context "when options contain :separator" do
      it do
        expect(:number_to_delimited).to convert(12_345_678.05)
                                          .with_options(separator: "-")
                                          .to("12,345,678-05")
      end
    end

    context "when options contain both :separator and :delimiter" do
      it do
        expect(:number_to_delimited).to convert(12_345_678.05)
                                          .with_options(separator: ",", delimiter: ".")
                                          .to("12.345.678,05")
      end
    end
  end
end
