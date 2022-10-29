require "test_helper"

class TagTest < ActiveSupport::TestCase
  def setup
    @tag = Tag.new(name: "Flower")
  end

  test 'valid tag' do
    assert @tag.valid?
  end

  test 'invalid without name' do
    @tag.name = nil
    refute @tag.valid?, "saved tag without a name"
    assert_not_nil @tag.errors[:name], "no validation error for name not present"
  end
end
