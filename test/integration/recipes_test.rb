require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @user = Chef.create!(chefname: "John", email: "john@example.com")
    @recipe1 = Recipe.create!(name: "Italian Food", description: "pasta cooker for 20 min in the oven", chef: @user)
    @recipe2 = Recipe.create!(name: "Brazilian Food", description: "bread cooker for 20 min in the oven", chef: @user)
  end

  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end

  test "should get recipes listing" do
    get recipes_url
    assert_template 'recipes/index'
    assert_match @recipe1.name, response.body
    assert_match @recipe2.name, response.body
  end

end
