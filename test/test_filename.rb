# test_filename.rb: Unit tests for the numren script.
#
# Copyright (C) 2011-2018 Marcus Stollsteimer

require "minitest/autorun"
load "numren"  unless defined?(Numren)


describe Numren::Filename do

  before do
    @fn = Numren::Filename.new("01_Sample.dat")
  end

  it "can be created" do
    _(Numren::Filename.new("01_Sample.dat")).must_be_instance_of Numren::Filename
    _(Numren::Filename.new("01_02_Sample.dat")).must_be_instance_of Numren::Filename
    _(Numren::Filename.new("00_Sample.dat")).must_be_instance_of Numren::Filename
  end

  it "should not accept ill-formed filenames" do
    assert_raises(Numren::FilenameError) { Numren::Filename.new("Sample.dat") }
    assert_raises(Numren::FilenameError) { Numren::Filename.new("_Sample.dat") }
    assert_raises(Numren::FilenameError) { Numren::Filename.new("01_") }
  end

  it "should only accept filenames starting with a number part" do
    assert_raises(Numren::FilenameError) { Numren::Filename.new("AB_Sample.dat") }
    assert_raises(Numren::FilenameError) { Numren::Filename.new("0A_Sample.dat") }
    assert_raises(Numren::FilenameError) { Numren::Filename.new("A0_Sample.dat") }
  end

  it "can be converted to string" do
    _(@fn.to_s).must_equal "01_Sample.dat"
  end

  it "can be compared to a string" do
    _(@fn).must_equal "01_Sample.dat"
    _("01_Sample.dat").must_equal @fn
    _(@fn).wont_equal "02_Sample.dat"
    _("02_Sample.dat").wont_equal @fn
  end

  it "can set its number part" do
    @fn.number = "2"
    _(@fn.to_s).must_equal "02_Sample.dat"
    @fn.number = "001"
    _(@fn.to_s).must_equal "001_Sample.dat"
    @fn.number = "0"
    _(@fn.to_s).must_equal "000_Sample.dat"
  end

  it "can increase its number part" do
    @fn.number = "+2"
    _(@fn.to_s).must_equal "03_Sample.dat"
    @fn.number = "+101"
    _(@fn.to_s).must_equal "104_Sample.dat"
  end

  it "can decrease its number part" do
    @fn.number = "11"
    @fn.number = "-2"
    _(@fn.to_s).must_equal "09_Sample.dat"
    @fn.number = "-9"
    _(@fn.to_s).must_equal "00_Sample.dat"
  end

  it "cannot decrease its number part below 0" do
    _ { @fn.number = "-2" }.must_raise Numren::FilenameError
  end

  it "updates the number of digits (if necessary) when increasing" do
    @fn.number = "99"
    @fn.number = "+1"
    @fn.number = "-1"
    _(@fn.to_s).must_equal "099_Sample.dat"
  end

  it "can set its number of digits" do
    @fn.number = "010"
    _(@fn.to_s).must_equal "010_Sample.dat"

    @fn.digits = 2
    _(@fn.to_s).must_equal "10_Sample.dat"
  end

  it "sets its number of digits only if possible" do
    @fn.number = "10"
    @fn.digits = 1
    _(@fn.to_s).must_equal "10_Sample.dat"
  end
end
