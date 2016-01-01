# test_string.rb: Unit tests for the numren script.
#
# Copyright (C) 2011-2016 Marcus Stollsteimer

require 'minitest/autorun'
load 'numren'  unless defined?(Numren)


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
