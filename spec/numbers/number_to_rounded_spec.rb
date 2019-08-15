# frozen_string_literal: true

require "spec_helper"
require "active_support/all"

#RSpec.describe "FasterSupport::Numbers.number_to_rounded" do
RSpec.describe :number_to_rounded do
  describe "number" do
    context "when a number is passed" do
      context "which is positive" do
        it { is_expected.to convert(111.2346).to("111.235") }

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
      context "and options[:precision] = 0" do
        it do
          is_expected.to convert(0)
                          .with_options(precision: 0)
                          .to("0")
        end

        it do
          is_expected.to convert(123.45)
                          .with_options(precision: 0)
                          .to("123")
        end

        it do
          is_expected.to convert_for_each_type(123.45)
                          .with_options(precision: 0)
                          .to("123")
        end

        it do
          is_expected.to convert(123.54)
                          .with_options(precision: 0)
                          .to("124")
        end

        it do
          is_expected.to convert(-123.45)
                          .with_options(precision: 0)
                          .to("-123")
        end

        it do
          is_expected.to convert(-123.45)
                          .with_options(precision: 0)
                          .to("-123")
        end

        it do
          is_expected.to convert(-123.54)
                          .with_options(precision: 0)
                          .to("-124")
        end

        it do
          is_expected.to convert(Rational(12345, 100))
                          .with_options(precision: 0)
                          .to("123")
        end

        it do
          is_expected.to convert(Rational(12354, 100))
                          .with_options(precision: 0)
                          .to("124")
        end

        it do
          is_expected.to convert(BigDecimal("123.45"))
                          .with_options(precision: 0)
                          .to("123")
        end

        it do
          is_expected.to convert("123.45")
                          .with_options(precision: 0)
                          .to("123")
        end
      end

      context "and options[:precision] is equal to the numbers of the fraction size" do
        it do
          is_expected.to convert(123.45)
                          .with_options(precision: 2)
                          .to("123.45")
        end

        it do
          is_expected.to convert(Rational(12345, 100))
                          .with_options(precision: 2)
                          .to("123.45")
        end

        it do
          is_expected.to convert(BigDecimal("123.45"))
                          .with_options(precision: 2)
                          .to("123.45")
        end

        it do
          is_expected.to convert("123.45")
                          .with_options(precision: 2)
                          .to("123.45")
        end
      end

      context "and options[:precision] is less than the numbers of the fraction size" do
        # Fractional

        it do
          is_expected.to convert(123.454)
                          .with_options(precision: 2)
                          .to("123.45")
        end

        it do
          is_expected.to convert(123.456)
                          .with_options(precision: 2)
                          .to("123.46")
        end

        it do
          is_expected.to convert(0.0001)
                          .with_options(precision: 3)
                          .to("0.000")
        end

        it do
          is_expected.to convert(0.0007)
                          .with_options(precision: 3)
                          .to("0.001")
        end

        it do
          is_expected.to convert(9.9994)
                          .with_options(precision: 3)
                          .to("9.99")
        end

        it do
          is_expected.to convert(9.9995)
                          .with_options(precision: 3)
                          .to("10.00")
        end

        it do
          is_expected.to convert(-1.00001)
                          .with_options(precision: 4)
                          .to("-1.0000")
        end

        it do
          is_expected.to convert(-0.00001)
                          .with_options(precision: 4)
                          .to("0.0000")
        end

        # Rational

        it do
          is_expected.to convert(Rational(123454, 1000))
                          .with_options(precision: 2)
                          .to("123.45")
        end

        it do
          is_expected.to convert(Rational(123456, 1000))
                          .with_options(precision: 2)
                          .to("123.46")
        end

        it do
          is_expected.to convert(Rational(1, 10000))
                          .with_options(precision: 3)
                          .to("0.000")
        end

        it do
          is_expected.to convert(Rational(7, 10000))
                          .with_options(precision: 3)
                          .to("0.001")
        end

        it do
          is_expected.to convert(Rational(99994, 10000))
                          .with_options(precision: 3)
                          .to("9.999")
        end

        it do
          is_expected.to convert(Rational(99995, 10000))
                          .with_options(precision: 3)
                          .to("10.000")
        end

        it do
          is_expected.to convert(Rational(-100001, 100000))
                          .with_options(precision: 4)
                          .to("-1.0000")
        end

        it do
          is_expected.to convert(Rational(-1, 100000))
                          .with_options(precision: 4)
                          .to("0.0000")
        end

        # BigDEcimal

        it do
          is_expected.to convert(BigDecimal("123.454"))
                          .with_options(precision: 2)
                          .to("123.45")
        end

        it do
          is_expected.to convert(BigDecimal("123.456"))
                          .with_options(precision: 2)
                          .to("123.46")
        end

        it do
          is_expected.to convert(BigDecimal("0.0001"))
                          .with_options(precision: 3)
                          .to("0.000")
        end

        it do
          is_expected.to convert(BigDecimal("0.0007"))
                          .with_options(precision: 3)
                          .to("0.001")
        end

        it do
          is_expected.to convert(BigDecimal("9.9994"))
                          .with_options(precision: 3)
                          .to("9.999")
        end

        it do
          is_expected.to convert(BigDecimal("9.9995"))
                          .with_options(precision: 3)
                          .to("10.000")
        end

        it do
          is_expected.to convert(BigDecimal("-1.00001"))
                          .with_options(precision: 4)
                          .to("-1.0000")
        end

        it do
          is_expected.to convert(BigDecimal("-0.00001"))
                          .with_options(precision: 4)
                          .to("0.0000")
        end

        # String

        it do
          is_expected.to convert("123.454")
                          .with_options(precision: 2)
                          .to("123.45")
        end

        it do
          is_expected.to convert("123.456")
                          .with_options(precision: 2)
                          .to("123.46")
        end

        it do
          is_expected.to convert("0.0001")
                          .with_options(precision: 3)
                          .to("0.000")
        end

        it do
          is_expected.to convert("0.0007")
                          .with_options(precision: 3)
                          .to("0.001")
        end

        it do
          is_expected.to convert("9.9994")
                          .with_options(precision: 3)
                          .to("9.999")
        end

        it do
          is_expected.to convert("9.9995")
                          .with_options(precision: 3)
                          .to("10.000")
        end

        it do
          is_expected.to convert("-1.00001")
                          .with_options(precision: 4)
                          .to("-1.0000")
        end

        it do
          is_expected.to convert("-0.00001")
                          .with_options(precision: 4)
                          .to("0.0000")
        end
      end

      context "and options[:precision] is greater than the numbers of the fraction size" do
        it do
          is_expected.to convert(111)
                          .with_options(precision: 2)
                          .to("111.00")
        end

        it do
          is_expected.to convert(0.001)
                          .with_options(precision: 5)
                          .to("0.00100")
        end

        it do
          is_expected.to convert(111.2346)
                          .with_options(precision: 20)
                          .to("111.23460000000000000000")
        end

        it do
          is_expected.to convert(Rational(1112346, 10000))
                          .with_options(precision: 20)
                          .to("111.23460000000000000000")
        end

        it do
          is_expected.to convert("111.2346")
                          .with_options(precision: 20)
                          .to("111.23460000000000000000")
        end

        it do
          is_expected.to convert(BigDecimal(111.2346, Float::DIG))
                          .with_options(precision: 20)
                          .to("111.23460000000000000000")
        end

        it do
          is_expected.to convert("111.2346")
                          .with_options(precision: 100)
                          .to("111.2346000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
        end

        it do
          is_expected.to convert(Rational(0, 1))
                          .with_options(precision: 2)
                          .to("0.00")
        end
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

    context "when options contain significant" do
      it do
        is_expected.to convert(123987)
                        .with_options(precision: 3, significant: true)
                        .to("124000")
      end

      it do
        is_expected.to convert(123987876)
                        .with_options(precision: 2, significant: true)
                        .to("120000000")
      end

      it do
        is_expected.to convert("43523")
                        .with_options(precision: 1, significant: true)
                        .to("40000")
      end

      it do
        is_expected.to convert(9775)
                        .with_options(precision: 4, significant: true)
                        .to("9775")
      end

      it do
        is_expected.to convert(5.3923)
                        .with_options(precision: 2, significant: true)
                        .to("5.4")
      end

      it do
        is_expected.to convert(5.3923)
                        .with_options(precision: 1, significant: true)
                        .to("5")
      end

      it do
        is_expected.to convert(1.232)
                        .with_options(precision: 1, significant: true)
                        .to("1")
      end

      it do
        is_expected.to convert(7)
                        .with_options(precision: 1, significant: true)
                        .to("7")
      end

      it do
        is_expected.to convert(1)
                        .with_options(precision: 1, significant: true)
                        .to("1")
      end

      it do
        is_expected.to convert(52.7923)
                        .with_options(precision: 2, significant: true)
                        .to("53")
      end

      it do
        is_expected.to convert(9775)
                        .with_options(precision: 6, significant: true)
                        .to("9775.00")
      end

      it do
        is_expected.to convert(5.3929)
                        .with_options(precision: 7, significant: true)
                        .to("5.392900")
      end

      it do
        is_expected.to convert(0)
                        .with_options(precision: 2, significant: true)
                        .to("0.0")
      end

      it do
        is_expected.to convert(0)
                        .with_options(precision: 1, significant: true)
                        .to("0")
      end

      it do
        is_expected.to convert(0.0001)
                        .with_options(precision: 1, significant: true)
                        .to("0.0001")
      end

      it do
        is_expected.to convert(0.0001)
                        .with_options(precision: 3, significant: true)
                        .to("0.000100")
      end

      it do
        is_expected.to convert(0.0001111)
                        .with_options(precision: 1, significant: true)
                        .to("0.0001")
      end

      it do
        is_expected.to convert(9.994)
                        .with_options(precision: 3, significant: true)
                        .to("9.99")
      end

      it do
        is_expected.to convert(9.995)
                        .with_options(precision: 3, significant: true)
                        .to("10.0")
      end

      it do
        is_expected.to convert(10.995)
                        .with_options(precision: 3, significant: true)
                        .to("11.0")
      end

      it do
        is_expected.to convert(999)
                        .with_options(precision: 1, significant: true)
                        .to("1000")
      end

      it do
        is_expected.to convert(999)
                        .with_options(precision: 3, significant: true)
                        .to("999")
      end

      it do
        is_expected.to convert(9775)
                        .with_options(precision: 20, significant: true)
                        .to("9775.0000000000000000")
      end

      it do
        is_expected.to convert(9775.0)
                        .with_options(precision: 20, significant: true)
                        .to("9775.0000000000000000")
      end

      it do
        is_expected.to convert(Rational(9775, 1))
                        .with_options(precision: 20, significant: true)
                        .to("9775.0000000000000000")
      end

      it do
        is_expected.to convert(Rational(9775, 100))
                        .with_options(precision: 20, significant: true)
                        .to("97.750000000000000000")
      end

      it do
        is_expected.to convert(BigDecimal(9775))
                        .with_options(precision: 20, significant: true)
                        .to("9775.0000000000000000")
      end

      it do
        is_expected.to convert("9775")
                        .with_options(precision: 20, significant: true)
                        .to("9775.0000000000000000")
      end

      it do
        is_expected.to convert("9775")
                        .with_options(precision: 100, significant: true)
                        .to("9775.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
      end

      it do
        is_expected.to convert(Rational(9772, 100))
                        .with_options(precision: 3, significant: true)
                        .to("97.7")
      end

      context "and options[:precision] = 0" do
        it do
          is_expected.to convert(123.987)
                          .with_options(precision: 0, significant: true)
                          .to("124")
        end

        it do
          is_expected.to convert(12)
                          .with_options(precision: 0, significant: true)
                          .to("12")
        end

        it do
          is_expected.to convert("12.3")
                          .with_options(precision: 0, significant: true)
                          .to("12")
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
  end
end
