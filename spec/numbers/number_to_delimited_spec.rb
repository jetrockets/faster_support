# frozen_string_literal: true

require 'spec_helper'
require 'active_support/all'

RSpec.describe "FasterSupport::Numbers.number_to_delimited" do
  let(:faster_support) do
    FasterSupport::Numbers.number_to_delimited(number, options)
  end

  let(:active_support) do
    ActiveSupport::NumberHelper.number_to_delimited(number, options)
  end

  let(:options) { {} }

  describe "number" do
    context "when a number is passed" do
      context "with less than 3 digits in its integer part" do
        let(:number) { 0 }

        it "returns a string " do
          expect(faster_support).to eq("0")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "with 3 digits in its integer part" do
        let(:number) { 123 }

        it "" do
          expect(faster_support).to eq("123")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "with the number of digits in its integer part that is devisible by 3" do
        let(:number) { 123_456 }

        it "" do
          expect(faster_support).to eq("123,456")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "with the number of digits in its integer part that is not devisible by 3" do
        let(:number) { 12_345_678 }

        it "" do
          expect(faster_support).to eq("12,345,678")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "with less than 3 digits in its fractional part" do
        let(:number) { 123_456.78 }

        it "" do
          expect(faster_support).to eq("123,456.78")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "with 3 digits in its fractional part" do
        let(:number) { 123_456.789 }

        it "" do
          expect(faster_support).to eq("123,456.789")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "with the number of digits in its fractional part that is devisible by 3" do
        let(:number) { 123_456.789012 }

        it "" do
          expect(faster_support).to eq("123,456.789012")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "with the number of digits in its fractional part that is not devisible by 3" do
        let(:number) { 123_456_789.78901 }

        it "" do
          expect(faster_support).to eq("123,456,789.78901")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "with only fractional part" do
        let(:number) { 0.78901 }

        it "" do
          expect(faster_support).to eq("0.78901")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "that is negative" do
        let(:number) { -123_456 }

        it "" do
          expect(faster_support).to eq("-123,456")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end
    end

    context "when a string is passed to" do
      context "which contains a positive number" do
        let(:number) { "123456.78" }

        it "" do
          expect(faster_support).to eq("123,456.78")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "which contains a negative number" do
        let(:number) { "-123456.78" }

        it "" do
          expect(faster_support).to eq("-123,456.78")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "which is html safe" do
        let(:number) { "123456.78".html_safe }

        it "" do
          expect(faster_support).to eq("123,456.78")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "which contains no numbers" do
        let(:number) { "This string does not contain any numbers" }

        it "" do
          expect(faster_support).to eq("This string does not contain any numbers")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end
    end

    context "when nil is passed to" do
      let(:number) { nil }

      it "returns nil" do
        expect(faster_support).to eq(nil)
      end

      it "returns the same value as ActiveSupport" do
        expect(faster_support).to eq(active_support)
      end
    end

    context "when an object that is not number or string is passed to" do
      let(:number) { [1, 2, 3] }

      it "returns the object that has been passed to" do
        expect(faster_support).to eq([1, 2, 3])
      end

      it "returns the same value as ActiveSupport" do
        expect(faster_support).to eq(active_support)
      end
    end
  end

  describe "options" do
    context "that contain :delimiter_pattern" do
      let(:number) { 123_456.78 }
      let(:options) { { delimiter_pattern: /(\d+?)(?=(\d\d)+(\d)(?!\d))/ } }

      pending "" do
        expect(faster_support).to eq("1,23,456.78")
      end

      pending "returns the same value as ActiveSupport" do
        expect(faster_support).to eq(active_support)
      end
    end

    context "that contain :delimiter" do
      let(:number) { 12_345_678 }
      let(:options) { { delimiter: " " } }

      it "" do
        expect(faster_support).to eq("12 345 678")
      end

      it "returns the same value as ActiveSupport" do
        expect(faster_support).to eq(active_support)
      end
    end

    context "that contain :separator" do
      let(:number) { 12_345_678.05 }
      let(:options) { { separator: "-" } }

      it "" do
        expect(faster_support).to eq("12,345,678-05")
      end

      it "returns the same value as ActiveSupport" do
        expect(faster_support).to eq(active_support)
      end
    end

    context "that contain both :separator and :delimiter" do
      let(:number) { 12_345_678.05 }
      let(:options) { { separator: ",", delimiter: "." } }

      it "" do
        expect(faster_support).to eq("12.345.678,05")
      end

      it "returns the same value as ActiveSupport" do
        expect(faster_support).to eq(active_support)
      end
    end
  end
end
