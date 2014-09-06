require 'minitest/autorun'
require_relative '../app/lists.rb'
require_relative 'list_interface_test.rb'

class FloralPrefixListTest < MiniTest::Test
  include ListInterfaceTest

  def setup
    @module = FloralPrefixList
  end
end

class FlowerNameListTest < MiniTest::Test
  include ListInterfaceTest

  def setup
    @module = FlowerNameList
  end
end

class LifeCycleTypeListTest < MiniTest::Test
  include ListInterfaceTest

  def setup
    @module = LifeCycleTypeList
  end
end

class FruitTypeListTest < MiniTest::Test
  include ListInterfaceTest

  def setup
    @module = FruitTypeList
  end
end

class ScentListTest < MiniTest::Test
  include ListInterfaceTest

  def setup
    @module = ScentList
  end
end

class FlowerAdjectivesWithoutAreListTest < MiniTest::Test
  include ListInterfaceTest

  def setup
    @module = FlowerAdjectivesWithoutAreList
  end
end

class AnimalListTest < MiniTest::Test
  include ListInterfaceTest

  def setup
    @module = AnimalList
  end
end

class EdibilityListTest < MiniTest::Test
  include ListInterfaceTest

  def setup
    @module = EdibilityList
  end
end

class DrugListTest < MiniTest::Test
  include ListInterfaceTest

  def setup
    @module = DrugList
  end
end

class ConsumptionMethodListTest < MiniTest::Test
  include ListInterfaceTest

  def setup
    @module = ConsumptionMethodList
  end
end
