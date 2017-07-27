require 'test_helper'

class ChefsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @chef1 = Chef.create!(chefname: "John1", email: "john1@example.com",
                          password: "password1", password_confirmation: "password1")
    @chef2 = Chef.create!(chefname: "John2", email: "john2@example.com",
                          password: "password2", password_confirmation: "password2")

  end

  test "should get listing page" do
    get chefs_path
    assert_template 'chefs/index'
    assert_match @chef1.chefname, response.body
    assert_select "a[href=?]", chef_path(@chef1), text: @chef1.chefname
    assert_match @chef2.chefname, response.body
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefname
  end

  test "should delete chef" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef1), text: "Delete this chef"
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef1)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end
end
