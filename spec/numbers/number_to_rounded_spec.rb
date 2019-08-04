# frozen_string_literal: true

require 'spec_helper'
require 'active_support/all'

RSpec.describe "FasterSupport::Numbers.number_to_rounded" do
  let(:faster_support) do
    FasterSupport::Numbers.number_to_rounded(number, options)
  end

  let(:active_support) do
    ActiveSupport::NumberHelper.number_to_rounded(number, options)
  end

  let(:options) { {} }

  describe "number" do
    context "when a number is passed" do
      context "which is positive" do
        let(:number) { 111.2346 }

        it "" do
          expect(faster_support).to eq("111.235")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "which is negative" do
        let(:number) { 111.2346 }

        it "" do
          expect(faster_support).to eq("-111.235")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end
    end

    context "when a string is passed to" do
      context "which represents a positive number" do
        let(:number) { "111.2346" }

        it "" do
          expect(faster_support).to eq("111.235")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "which represents a negative number" do
        let(:number) { "-111.2346" }

        it "" do
          expect(faster_support).to eq("-111.235")
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
    context "when options contain :precision" do
      context "" do
        let(:number) { 31.825 }
        let(:options) { { precision: 2 } }

        it "" do
          expect(faster_support).to eq("31.83")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 111.2346 }
        let(:options) { { precision: 2 } }

        it "" do
          expect(faster_support).to eq("111.23")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 111 }
        let(:options) { { precision: 2 } }

        it "" do
          expect(faster_support).to eq("111.00")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { (32.6751 * 100.00) }
        let(:options) { { precision: 0 } }

        it "" do
          expect(faster_support).to eq("3268")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 111.50 }
        let(:options) { { precision: 0 } }

        it "" do
          expect(faster_support).to eq("112")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 1234567891.50 }
        let(:options) { { precision: 0 } }

        it "" do
          expect(faster_support).to eq("1234567892")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 0 }
        let(:options) { { precision: 0 } }

        it "" do
          expect(faster_support).to eq("0")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 0.001 }
        let(:options) { { precision: 5 } }

        it "" do
          expect(faster_support).to eq("0.00100")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 0.00111 }
        let(:options) { { precision: 3 } }

        it "" do
          expect(faster_support).to eq("0.001")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 9.995 }
        let(:options) { { precision: 2 } }

        it "" do
          expect(faster_support).to eq("10.00")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 10.995 }
        let(:options) { { precision: 2 } }

        it "" do
          expect(faster_support).to eq("11.00")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { -0.001 }
        let(:options) { { precision: 2 } }

        it "" do
          expect(faster_support).to eq("0.00")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 111.2346 }
        let(:options) { { precision: 20 } }

        it "" do
          expect(faster_support).to eq("111.23460000000000000000")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { Rational(1112346, 10000) }
        let(:options) { { precision: 20 } }

        it "" do
          expect(faster_support).to eq("111.23460000000000000000")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { "111.2346" }
        let(:options) { { precision: 20 } }

        it "" do
          expect(faster_support).to eq("111.23460000000000000000")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { BigDecimal(111.2346, Float::DIG) }
        let(:options) { { precision: 20 } }

        it "" do
          expect(faster_support).to eq("111.23460000000000000000")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { "111.2346" }
        let(:options) { { precision: 100 } }

        it "" do
          expect(faster_support).to eq("111.2346" + "0" * 96)
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { Rational(1112346, 10000) }
        let(:options) { { precision: 4 } }

        it "" do
          expect(faster_support).to eq("111.2346")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { Rational(0, 1) }
        let(:options) { { precision: 2 } }

        it "" do
          expect(faster_support).to eq("0.00")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 31.825 }
        let(:options) { { precision: 2, separator: "," } }

        it "" do
          expect(faster_support).to eq("31,83")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end
    end

    context "when options contain :separator" do
      let(:number) { 1231.825 }
      let(:options) { { precision: 2, separator: ",", delimiter: "." } }

      it "" do
        expect(faster_support).to eq("1.231,83")
      end

      it "returns the same value as ActiveSupport" do
        expect(faster_support).to eq(active_support)
      end
    end

    context "when options contain :delimeter" do
      let(:number) { 1231.825 }
      let(:options) { { precision: 2, separator: ",", delimiter: "." } }

      it "" do
        expect(faster_support).to eq("1.231,83")
      end

      it "returns the same value as ActiveSupport" do
        expect(faster_support).to eq(active_support)
      end
    end

    context "when options[:significant] = true" do
      context "" do
        let(:number) { 123987 }
        let(:options) { { precision: 3, significant: true } }

        it "" do
          expect(faster_support).to eq("124000")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 123987876 }
        let(:options) { { precision: 2, significant: true } }

        it "" do
          expect(faster_support).to eq("120000000")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { "43523" }
        let(:options) { { precision: 1, significant: true } }

        it "" do
          expect(faster_support).to eq("40000")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 9775 }
        let(:options) { { precision: 4, significant: true } }

        it "" do
          expect(faster_support).to eq("9775")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 5.3923 }
        let(:options) { { precision: 2, significant: true } }

        it "" do
          expect(faster_support).to eq("5.4")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 5.3923 }
        let(:options) { { precision: 1, significant: true } }

        it "" do
          expect(faster_support).to eq("5")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 1.232 }
        let(:options) { { precision: 1, significant: true } }

        it "" do
          expect(faster_support).to eq("1")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 7 }
        let(:options) { { precision: 1, significant: true } }

        it "" do
          expect(faster_support).to eq("7")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 1 }
        let(:options) { { precision: 1, significant: true } }

        it "" do
          expect(faster_support).to eq("1")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 52.7923 }
        let(:options) { { precision: 2, significant: true } }

        it "" do
          expect(faster_support).to eq("53")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 9775 }
        let(:options) { { precision: 6, significant: true } }

        it "" do
          expect(faster_support).to eq("9775.00")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 5.3929 }
        let(:options) { { precision: 7, significant: true } }

        it "" do
          expect(faster_support).to eq("5.392900")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 0 }
        let(:options) { { precision: 2, significant: true } }

        it "" do
          expect(faster_support).to eq("0.0")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 0 }
        let(:options) { { precision: 1, significant: true } }

        it "" do
          expect(faster_support).to eq("0")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 0.0001 }
        let(:options) { { precision: 1, significant: true } }

        it "" do
          expect(faster_support).to eq("0.0001")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 0.0001 }
        let(:options) { { precision: 3, significant: true } }

        it "" do
          expect(faster_support).to eq("0.000100")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 0.0001111 }
        let(:options) { { precision: 1, significant: true } }

        it "" do
          expect(faster_support).to eq("0.0001")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 9.995 }
        let(:options) { { precision: 3, significant: true } }

        it "" do
          expect(faster_support).to eq("10.0")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 9.994 }
        let(:options) { { precision: 3, significant: true } }

        it "" do
          expect(faster_support).to eq("9.99")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 10.995 }
        let(:options) { { precision: 3, significant: true } }

        it "" do
          expect(faster_support).to eq("11.0")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 9775 }
        let(:options) { { precision: 20, significant: true } }

        it "" do
          expect(faster_support).to eq("9775.0000000000000000")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 9775.0 }
        let(:options) { { precision: 20, significant: true } }

        it "" do
          expect(faster_support).to eq("9775.0000000000000000")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { Rational(9775, 1) }
        let(:options) { { precision: 20, significant: true } }

        it "" do
          expect(faster_support).to eq("9775.0000000000000000")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { Rational(9775, 100) }
        let(:options) { { precision: 20, significant: true } }

        it "" do
          expect(faster_support).to eq("97.750000000000000000")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { BigDecimal(9775) }
        let(:options) { { precision: 20, significant: true } }

        it "" do
          expect(faster_support).to eq("9775.0000000000000000")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { "9775" }
        let(:options) { { precision: 20, significant: true } }

        it "" do
          expect(faster_support).to eq("9775.0000000000000000")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { "9775" }
        let(:options) { { precision: 100, significant: true } }

        it "" do
          expect(faster_support).to eq("9775." + "0" * 96)
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { Rational(9772, 100) }
        let(:options) { { precision: 3, significant: true } }

        it "" do
          expect(faster_support).to eq("97.7")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 123.987 }
        let(:options) { { precision: 0, significant: true } }

        it "" do
          expect(faster_support).to eq("124")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 12 }
        let(:options) { { precision: 0, significant: true } }

        it "" do
          expect(faster_support).to eq("12")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { "12.3" }
        let(:options) { { precision: 0, significant: true } }

        it "" do
          expect(faster_support).to eq("12")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end
    end

    context "when options[:strip_insignificant_zeros] = true" do
      context "" do
        let(:number) { 9775.43 }
        let(:options) { { precision: 4, strip_insignificant_zeros: true } }

        it "" do
          expect(faster_support).to eq("9775.43")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 9775.2 }
        let(:options) { { precision: 6, significant: true, strip_insignificant_zeros: true } }

        it "" do
          expect(faster_support).to eq("9775.2")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end

      context "" do
        let(:number) { 0 }
        let(:options) { { precision: 6, significant: true, strip_insignificant_zeros: true } }

        it "" do
          expect(faster_support).to eq("0")
        end

        it "returns the same value as ActiveSupport" do
          expect(faster_support).to eq(active_support)
        end
      end
    end
  end
end
