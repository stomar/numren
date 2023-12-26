# frozen_string_literal: true

require "minitest/autorun"
load "numren"  unless defined?(Numren)


describe String do

  describe "when asked if string represents an integer" do
    it "should recognize valid integers" do
      _("3".is_i?).must_equal true
      _("01".is_i?).must_equal true
      _("42".is_i?).must_equal true
      _("123".is_i?).must_equal true
      _("0".is_i?).must_equal true
    end

    it "should recognize non-integers" do
      _("A".is_i?).must_equal false
      _("0A".is_i?).must_equal false
      _("A0".is_i?).must_equal false
      _("".is_i?).must_equal false
    end

    it "should recognize signed integers" do
      _("+5".is_i?).must_equal true
      _("-2".is_i?).must_equal true
      _("+02".is_i?).must_equal true
      _("1+2".is_i?).must_equal false
      _("3-2".is_i?).must_equal false
    end
  end
end
