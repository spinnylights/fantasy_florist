module GeneratorInterfaceTest
  def test_responds_to_generate
    assert_respond_to @object, :generate
  end

  def test_generate_returns_string
    assert_kind_of String, @object.generate
  end
end
