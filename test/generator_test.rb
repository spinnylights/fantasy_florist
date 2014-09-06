require 'minitest/autorun'
require_relative '../app/generator.rb'
require_relative 'generator_interface_test.rb'

class GeneratorTest < MiniTest::Test
  include GeneratorInterfaceTest

  def sample_string_arr
    [
      'bag',
      'wag'
    ]
  end

  def setup
    @gen = @object = Generator.new( sample_string_arr )
  end

  def test_generate
    assert sample_string_arr.include?( @gen.generate ), "#{@gen.generate} wasn't found in #{sample_string_arr}"
  end
end

class GenDoubleOne
  def generate
      'bag'
  end
end

class GenDoubleTwo
  def generate
    'sag'
  end
end

class SimpleCombinatorTest < MiniTest::Test
  include GeneratorInterfaceTest

  def setup
    @gen = @object = SimpleCombinator.new(
      GenDoubleOne.new,
      GenDoubleTwo.new
    )
  end

  def expected_gen_output
    GenDoubleOne.new.generate + ' ' + GenDoubleTwo.new.generate
  end

  def test_generate_combines_generators
    assert_equal expected_gen_output, @gen.generate
  end
end

class FlowerPhraseCombinatorTest < MiniTest::Test
  include GeneratorInterfaceTest

  def setup
    @gen = @object = FlowerPhraseCombinator.new
  end
end

class MasterCombinatorTest < MiniTest::Test
  include GeneratorInterfaceTest

  def setup
    @gen = @object = MasterCombinator.new
  end
end
