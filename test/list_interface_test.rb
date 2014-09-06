module ListInterfaceTest
  def test_respond_to_list
    assert_respond_to @module, :list
  end

  def test_list_returns_array
    assert_kind_of Array, @module.list
  end

  def test_list_arr_contains_strings
    @module.list.each do |str|
      assert_kind_of String, str
    end
  end
end
