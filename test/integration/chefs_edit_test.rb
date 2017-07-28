require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "John", email: "john@example.com",
                    password: "password", password_confirmation: "password")
  end

  test "reject an invalid edit" do
    sign_in_as(@chef, "password")
    get "/chefs/#{@chef.id}/edit", params: {:id => @chef.id}
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {chefname: "", email: "bonfimoliveira@gmail.com"}}
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "accept valid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    get "/chefs/#{@chef.id}/edit", params: {:id => @chef.id}
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {chefname: "john111", email: "john111@example.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "john111", @chef.chefname
    assert_match "john111@example.com", @chef.email
  end



end
