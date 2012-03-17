#!/usr/bin/ruby -w
# test_numren: Unit tests for the numren script.
#
# Copyright (C) 2011-2012 Marcus Stollsteimer

require 'minitest/spec'
require 'minitest/autorun'
load 'numren'


describe String do

  describe 'when asked if string represents an integer' do
    it 'should recognize valid integers' do
      '3'.is_i?.must_equal true
      '01'.is_i?.must_equal true
      '42'.is_i?.must_equal true
      '123'.is_i?.must_equal true
      '0'.is_i?.must_equal true
    end

    it 'should recognize non-integers' do
      'A'.is_i?.must_equal false
      '0A'.is_i?.must_equal false
      'A0'.is_i?.must_equal false
      ''.is_i?.must_equal false
    end

    it 'should recognize signed integers' do
      '+5'.is_i?.must_equal true
      '-2'.is_i?.must_equal true
      '+02'.is_i?.must_equal true
      '1+2'.is_i?.must_equal false
      '3-2'.is_i?.must_equal false
    end
  end
end


describe Numren::Filename do

  before do
    @fn = Numren::Filename.new('01_Sample.dat')
  end

  it 'can be created' do
    Numren::Filename.new('01_Sample.dat').must_be_instance_of Numren::Filename
    Numren::Filename.new('01_02_Sample.dat').must_be_instance_of Numren::Filename
    Numren::Filename.new('00_Sample.dat').must_be_instance_of Numren::Filename
  end

  it 'should not accept ill-formed filenames' do
    assert_raises(ArgumentError) { Numren::Filename.new('Sample.dat') }
    assert_raises(ArgumentError) { Numren::Filename.new('_Sample.dat') }
    assert_raises(ArgumentError) { Numren::Filename.new('01_') }
  end

  it 'should only accept filenames starting with a number part' do
    assert_raises(ArgumentError) { Numren::Filename.new('AB_Sample.dat') }
    assert_raises(ArgumentError) { Numren::Filename.new('0A_Sample.dat') }
    assert_raises(ArgumentError) { Numren::Filename.new('A0_Sample.dat') }
  end

  it 'can be converted to string' do
    @fn.to_s.must_equal '01_Sample.dat'
  end

  it 'can set its number part' do
    @fn.set_number 2      # a number
    @fn.to_s.must_equal '02_Sample.dat'
    @fn.set_number '001'  # a string
    @fn.to_s.must_equal '001_Sample.dat'
    @fn.set_number 0      # zero
    @fn.to_s.must_equal '000_Sample.dat'
  end

  it 'can increase its number part' do
    @fn.set_number '+2'
    @fn.to_s.must_equal '03_Sample.dat'
    @fn.set_number '+101'
    @fn.to_s.must_equal '104_Sample.dat'
  end

  it 'can decrease its number part' do
    @fn.set_number 11
    @fn.set_number '-2'
    @fn.to_s.must_equal '09_Sample.dat'
    @fn.set_number '-9'
    @fn.to_s.must_equal '00_Sample.dat'
  end

  it 'can not decrease its number part below 0' do
    lambda { @fn.set_number '-2' }.must_raise RuntimeError
  end

  it 'updates the number of digits (if necessary) when increasing' do
    @fn.set_number '99'
    @fn.set_number '+1'
    @fn.set_number '-1'
    @fn.to_s.must_equal '099_Sample.dat'
  end

  it 'can set its number of digits' do
    @fn.set_number '010'
    @fn.to_s.must_equal '010_Sample.dat'

    @fn.set_digits(2).must_equal true
    @fn.to_s.must_equal '10_Sample.dat'
  end

  it 'sets its number of digits only if possible' do
    @fn.set_number 10
    @fn.set_digits(1).must_equal false
    @fn.to_s.must_equal '10_Sample.dat'
  end
end


describe Numren::Optionparser do

  it 'should return the correct default values' do
    options = Numren::Optionparser.parse!(['01_Sample.txt', '02_Sample.txt', '+10'])
    expected = {
      :files => ['01_Sample.txt', '02_Sample.txt'],
      :number => '+10',
      :digits => nil
    }
    options.must_equal expected
  end

  it 'should recognize the -d option and return the correct default values' do
    options = Numren::Optionparser.parse!(['-d', '1', '01_Sample.txt', '02_Sample.txt'])
    expected = {
      :files => ['01_Sample.txt', '02_Sample.txt'],
      :number => nil,
      :digits => 1
    }
    options.must_equal expected
  end

  it 'should not accept invalid -d option values' do
    lambda { Numren::Optionparser.parse!(['-d', '0.5', '01_Sample.txt']) }.must_raise OptionParser::InvalidArgument
    lambda { Numren::Optionparser.parse!(['-d',   '0', '01_Sample.txt']) }.must_raise OptionParser::InvalidArgument
    lambda { Numren::Optionparser.parse!(['-d',  '-1', '01_Sample.txt']) }.must_raise OptionParser::InvalidArgument
  end

  it 'should not accept wrong number of arguments' do
    lambda { Numren::Optionparser.parse!(['01_Sample.txt']) }.must_raise ArgumentError
    lambda { Numren::Optionparser.parse!(['']) }.must_raise ArgumentError
    lambda { Numren::Optionparser.parse!([]) }.must_raise ArgumentError
    lambda { Numren::Optionparser.parse!(['-d', '1']) }.must_raise ArgumentError
  end

  it 'should not accept invalid options' do
    lambda { Numren::Optionparser.parse!(['-x']) }.must_raise OptionParser::InvalidOption
  end
end
