# frozen_string_literal: true

require "spec_helper"
require "active_support/all"

RSpec.describe :number_to_rounded do
  describe "number" do
    context "when a number is passed" do
      context "which is positive" do
        it { is_expected.to convert(111.2346).to("111.235") }
      end

      context "which is negative" do
        it { is_expected.to convert(-111.2346).to("-111.235") }
      end
    end

    context "when a string is passed to" do
      context "which represents a positive number" do
        it { is_expected.to convert("111.2346").to("111.235") }
      end

      context "which represents a negative number" do
        it { is_expected.to convert("-111.2346").to("-111.235") }
      end

      context "which contains no numbers" do
        it do
          is_expected.to convert("This string does not contain any numbers")
                          .to("This string does not contain any numbers")
        end
      end
    end

    context "when nil is passed to" do
      it { is_expected.to convert(nil).to(nil) }
    end

    context "when an object that is not number or string is passed to" do
      it { is_expected.to convert([1, 2, 3]).to([1, 2, 3]) }
    end
  end

  describe "options" do
    context "when options contain :precision" do
      context "and options[:precision] is equal to the size of the fraction part" do
        it do
          is_expected.to convert_as_integer(123)
                          .with_options(precision: 0)
                          .to("123")
        end

        it do
          is_expected.to convert_as_fractional(123.45)
                          .with_options(precision: 2)
                          .to("123.45")
        end

        it do
          is_expected.to convert_as_fractional(0.001)
                          .with_options(precision: 3)
                          .to("0.001")
        end

        it do
          is_expected.to convert_as_fractional(9.9994)
                          .with_options(precision: 4)
                          .to("9.9994")
        end

        it do
          is_expected.to convert_as_integer(-123)
                          .with_options(precision: 0)
                          .to("-123")
        end

        it do
          is_expected.to convert_as_fractional(-123.45)
                          .with_options(precision: 2)
                          .to("-123.45")
        end
      end

      context "and options[:precision] is less than the size of the fraction part" do
        it do
          is_expected.to convert_as_fractional(123.0)
                          .with_options(precision: 0)
                          .to("123")
        end

        it do
          is_expected.to convert_as_fractional(123.454)
                          .with_options(precision: 2)
                          .to("123.45")
        end

        it do
          is_expected.to convert_as_fractional(123.455)
                          .with_options(precision: 2)
                          .to("123.46")
        end

        it do
          is_expected.to convert_as_fractional(0.0001)
                          .with_options(precision: 3)
                          .to("0.000")
        end

        it do
          is_expected.to convert_as_fractional(0.0007)
                          .with_options(precision: 3)
                          .to("0.001")
        end

        it do
          is_expected.to convert_as_fractional(9.99994)
                          .with_options(precision: 4)
                          .to("9.9999")
        end

        it do
          is_expected.to convert_as_fractional(9.99995)
                          .with_options(precision: 4)
                          .to("10.0000")
        end

        it do
          is_expected.to convert_as_fractional(-123.0)
                          .with_options(precision: 0)
                          .to("-123")
        end

        it do
          is_expected.to convert_as_fractional(-123.454)
                          .with_options(precision: 2)
                          .to("-123.45")
        end

        it do
          is_expected.to convert_as_fractional(-0.0001)
                          .with_options(precision: 3)
                          .to("0.000")
        end

        it do
          is_expected.to convert_as_fractional(-0.0007)
                          .with_options(precision: 3)
                          .to("-0.001")
        end
      end

      context "and options[:precision] is greater than the size of the fraction part" do
        it do
          is_expected.to convert_as_integer(123)
                          .with_options(precision: 2)
                          .to("123.00")
        end

        it do
          is_expected.to convert_as_fractional(123.45)
                          .with_options(precision: 5)
                          .to("123.45000")
        end

        it do
          is_expected.to convert_as_fractional(0.0001)
                          .with_options(precision: 10)
                          .to("0.000100000")
        end

        it do
          is_expected.to convert_as_fractional(9.99994)
                          .with_options(precision: 50)
                          .to("9.99994000000000000000000000000000000000000000000000")
        end

        it do
          is_expected.to convert_as_fractional(-123)
                          .with_options(precision: 2)
                          .to("-123.00")
        end

        it do
          is_expected.to convert_as_fractional(-123.45)
                          .with_options(precision: 5)
                          .to("-123.45000")
        end
      end
    end

    context "when options contain significant" do
      context "and options[:precision] is equal to the number of significant digits" do
        it do
          is_expected.to convert_as_integer(123)
                          .with_options(precision: 3, significant: true)
                          .to("123")
        end

        it do
          is_expected.to convert_as_fractional(123.45)
                          .with_options(precision: 5, significant: true)
                          .to("123.45")
        end

        it do
          is_expected.to convert_as_fractional(0.0001)
                          .with_options(precision: 1, significant: true)
                          .to("0.0001")
        end

        it do
          is_expected.to convert_as_fractional(0.00123)
                          .with_options(precision: 3, significant: true)
                          .to("0.00123")
        end

        it do
          is_expected.to convert_as_integer(-123)
                          .with_options(precision: 3, significant: true)
                          .to("-123")
        end

        it do
          is_expected.to convert_as_fractional(-123.45)
                          .with_options(precision: 5, significant: true)
                          .to("-123.45")
        end

        it do
          is_expected.to convert_as_fractional(-0.0001)
                          .with_options(precision: 1, significant: true)
                          .to("-0.0001")
        end

        it do
          is_expected.to convert_as_fractional(-0.00123)
                          .with_options(precision: 3, significant: true)
                          .to("-0.00123")
        end
      end

      context "and options[:precision] is less than the number of significant digits" do
        it do
          is_expected.to convert_as_integer(23456)
                          .with_options(precision: 2, significant: true)
                          .to("23000")
        end

        it do
          is_expected.to convert_as_integer(23546)
                          .with_options(precision: 2, significant: true)
                          .to("24000")
        end

        it do
          is_expected.to convert_as_integer(999)
                          .with_options(precision: 1, significant: true)
                          .to("1000")
        end

        it do
          is_expected.to convert_as_fractional(123.45)
                          .with_options(precision: 3, significant: true)
                          .to("123")
        end

        it do
          is_expected.to convert_as_fractional(123.54)
                          .with_options(precision: 3, significant: true)
                          .to("124")
        end

        it do
          is_expected.to convert_as_fractional(12345.67)
                          .with_options(precision: 4, significant: true)
                          .to("12350")
        end

        it do
          is_expected.to convert_as_fractional(12344.67)
                          .with_options(precision: 4, significant: true)
                          .to("12340")
        end

        it do
          is_expected.to convert_as_fractional(999.4)
                          .with_options(precision: 3, significant: true)
                          .to("999")
        end

        it do
          is_expected.to convert_as_fractional(999.5)
                          .with_options(precision: 3, significant: true)
                          .to("1000")
        end

        it do
          is_expected.to convert_as_fractional(123.45)
                          .with_options(precision: 4, significant: true)
                          .to("123.5")
        end

        it do
          is_expected.to convert_as_fractional(123.44)
                          .with_options(precision: 4, significant: true)
                          .to("123.4")
        end

        it do
          is_expected.to convert_as_fractional(9.994)
                          .with_options(precision: 3, significant: true)
                          .to("9.99")
        end

        it do
          is_expected.to convert_as_fractional(9.995)
                          .with_options(precision: 3, significant: true)
                          .to("10.0")
        end

        it do
          is_expected.to convert_as_fractional(0.0012345)
                          .with_options(precision: 3, significant: true)
                          .to("0.00123")
        end

        it do
          is_expected.to convert_as_fractional(0.0012354)
                          .with_options(precision: 3, significant: true)
                          .to("0.00124")
        end

        it do
          is_expected.to convert_as_integer(123)
                          .with_options(precision: 0, significant: true)
                          .to("123")
        end

        it do
          is_expected.to convert_as_fractional(123.45)
                          .with_options(precision: 0, significant: true)
                          .to("123")
        end

        it do
          is_expected.to convert_as_fractional(123.54)
                          .with_options(precision: 0, significant: true)
                          .to("124")
        end

        it do
          is_expected.to convert_as_integer(-23456)
                          .with_options(precision: 2, significant: true)
                          .to("-23000")
        end

        it do
          is_expected.to convert_as_fractional(-123.45)
                          .with_options(precision: 3, significant: true)
                          .to("-123")
        end

        it do
          is_expected.to convert_as_fractional(-123.45)
                          .with_options(precision: 4, significant: true)
                          .to("-123.5")
        end

        it do
          is_expected.to convert_as_fractional(-0.0012345)
                          .with_options(precision: 3, significant: true)
                          .to("-0.00123")
        end

        it do
          is_expected.to convert_as_fractional(-0.0015432)
                          .with_options(precision: 1, significant: true)
                      .to("-0.002")
        end

        it do
          is_expected.to convert_as_fractional(-123.45)
                          .with_options(precision: 0, significant: true)
                          .to("-123")
        end
      end

      context "and options[:precision] is greater than the number of significant digits" do
        it do
          is_expected.to convert_as_integer(0)
                          .with_options(precision: 2, significant: true)
                          .to("0.0")
        end

        it do
          is_expected.to convert_as_integer(1234)
                          .with_options(precision: 6, significant: true)
                          .to("1234.00")
        end

        it do
          is_expected.to convert(123.45)
                          .with_options(precision: 7, significant: true)
                          .to("123.4500")
        end

        it do
          is_expected.to convert(0.0001)
                          .with_options(precision: 3, significant: true)
                          .to("0.000100")
        end

        it do
          is_expected.to convert_as_fractional(9.99994)
                          .with_options(precision: 20, significant: true)
                          .to("9.9999400000000000000")
        end

        it do
          is_expected.to convert_as_integer(-1234)
                          .with_options(precision: 6, significant: true)
                          .to("-1234.00")
        end

        it do
          is_expected.to convert(-123.45)
                          .with_options(precision: 7, significant: true)
                          .to("-123.4500")
        end

        it do
          is_expected.to convert(-0.0001)
                          .with_options(precision: 3, significant: true)
                          .to("-0.000100")
        end

        it do
          is_expected.to convert_as_fractional(-9.99994)
                          .with_options(precision: 20, significant: true)
                          .to("-9.9999400000000000000")
        end
      end
    end

    context "when options[:strip_insignificant_zeros] = true" do
      it do
        is_expected.to convert(9775.43)
                        .with_options(precision: 4, strip_insignificant_zeros: true)
                        .to("9775.43")
      end

      it do
        is_expected.to convert(9775.2)
                        .with_options(precision: 6, significant: true, strip_insignificant_zeros: true)
                        .to("9775.2")
      end

      it do
        is_expected.to convert(0)
                        .with_options(precision: 6, significant: true, strip_insignificant_zeros: true)
                        .to("0")
      end
    end

    context "when options contain :separator" do
      it do
        is_expected.to convert(1231.825)
                        .with_options(precision: 2, separator: ",", delimiter: ".")
                        .to("1.231,83")
      end

      it do
        is_expected.to convert(31.825)
                        .with_options(precision: 2, separator: ",")
                        .to("31,83")
      end
    end

    context "when options contain :delimeter" do
      it do
        is_expected.to convert(1231.825)
                        .with_options(precision: 2, separator: ",", delimiter: ".")
                        .to("1.231,83")
      end
    end
  end
end
