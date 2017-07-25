require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "John", email: "john@example.com")
    @recipe1 = Recipe.create!(name: "Italian Food", description: "pasta cooker for 20 min in the oven", chef: @chef)
    @recipe2 = Recipe.create!(name: "Brazilian Food", description: "bread cooker for 20 min in the oven", chef: @chef)
  end

  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end

  test "should get recipes listing" do
    get recipes_url
    # para entregar o template
    assert_template 'recipes/index'
    # para buscar palavras dentro de uma página html
    assert_match @recipe1.name, response.body
    # para buscar um link específico
    assert_select "a[href=?]", recipe_path(@recipe1), text: @recipe1.name
    assert_match @recipe2.name, response.body
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end

  test "should get recipes show" do
    get recipe_path(@recipe1)
    assert_template 'recipes/show'
    assert_match @recipe1.name.capitalize, response.body
    assert_match @recipe1.description, response.body
    assert_match @chef.chefname, response.body
  end

  test "create new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = 'chicken saute'
    description_of_recipe = 'chicken cooked in 20 min in the oven, serve the delicious meal!'
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: {recipe: {name: name_of_recipe, description: description_of_recipe}}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end

  test "reject invalid recipe submissions" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: {recipe: {name: "", description: ""}}
    end
    assert_template 'recipes/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
