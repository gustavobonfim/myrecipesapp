require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "John", email: "john@example.com",
                    password: "password", password_confirmation: "password")
    @recipe1 = Recipe.create!(name: "Italian Food", description: "pasta cooker for 20 min in the oven", chef: @chef)
    @recipe2 = Recipe.create!(name: "Brazilian Food", description: "bread cooker for 20 min in the oven", chef: @chef)
  end

  test "should only show chefs recipes" do
    get "/chefs/#{@chef.id}", params: {:id => @chef.id}
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe1), text: @recipe1.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe1.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname, response.body
  end

end
