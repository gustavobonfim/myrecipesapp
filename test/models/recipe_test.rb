require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def setup
    @recipe = Recipe.new(name: "Vegetable", description: "Great vegetable recipe")
  end

  test "recipe should be valid" do
    @recipe.save
    assert true, "Recipe was saved"
  end

  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end

  test "description should be presente" do
    @recipe.description = " "
    assert_not @recipe.valid?, "Saved the recipe without description"
  end

  test "description should not be too long" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?, "Saved the recipe too long"
  end

  test "description should not be too short" do
    @recipe.description = "a" * 9
    assert_not @recipe.valid?, "Saved the recipe too short"
  end
end
