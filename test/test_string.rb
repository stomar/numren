# frozen_string_literal: true

require "minitest/autorun"
load "numren"  unless defined?(Numren)


describe String do

  describe "when asked if string represents an integer" do
    it "should recognize valid integers" do
      _("3".integer?).must_equal true
      _("01".integer?).must_equal true
      _("42".integer?).must_equal true
      _("123".integer?).must_equal true
      _("0".integer?).must_equal true
    end

    it "should recognize non-integers" do
      _("A".integer?).must_equal false
      _("0A".integer?).must_equal false
      _("A0".integer?).must_equal false
      _("".integer?).must_equal false
    end

    it "should recognize signed integers" do
      _("+5".integer?).must_equal true
      _("-2".integer?).must_equal true
      _("+02".integer?).must_equal true
      _("1+2".integer?).must_equal false
      _("3-2".integer?).must_equal false
    end
  end
end
