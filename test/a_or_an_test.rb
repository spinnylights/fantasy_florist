require 'minitest/autorun'
require_relative '../app/a_or_an.rb'

class AOrAnTest < MiniTest::Test
  def test_returning_a
    assert_equal 'a', AOrAn.a_or_an('bag')
  end

  def starting_with_vowels
    [
      'ag',
      'eg',
      'ig',
      'og',
      'ug'
    ]
  end

  def test_returning_an
    starting_with_vowels.each do |word|
      assert_equal 'an', AOrAn.a_or_an( word )
    end
  end
end
