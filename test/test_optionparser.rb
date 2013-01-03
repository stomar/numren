# test_optionparser.rb: Unit tests for the numren script.
#
# Copyright (C) 2011-2013 Marcus Stollsteimer

require 'minitest/spec'
require 'minitest/autorun'
load 'numren'  unless defined?(Numren)


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
