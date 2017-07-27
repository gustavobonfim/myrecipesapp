require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "John", email: "john@example.com",
                    password: "password", password_confirmation: "password")
  end

  test "chef should be valid" do
    assert @chef.valid?, "Chef can be saved"
  end

  test "chefname should be valid" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "email should be valid" do
    @chef.email = " "
    assert_not @chef.valid?, "Chef saved without valid email"
  end

  test "Chefname should not be too short" do
    @chef.chefname = "a" * 3
    assert_not @chef.valid?, "Chef saved too short"
  end

  test "Chefname should not be too long" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?, "Chef saved too long"
  end

  test "Email should not be too long" do
    @chef.email = "a" * 256
    assert_not @chef.valid?, "Email saved too long"
  end

  test "email should be correct format" do
    valid_emails = %w[user@example.com user@gmail.com userfirst@yahoo.com.br john@hotmail.com]
    valid_emails.each do |valid|
      @chef.email = valid
      assert @chef.valid?, "#{valid.inspect} should be valid?"
    end
  end

  test "should reject invalid addresses" do
    invalid_emails = %w[user@example user@gmail,com userfirst@yahoo. john+hotmail.com]
    invalid_emails.each do |invalid|
      @chef.email = invalid
      assert @chef.invalid?, "#{invalid.inspect} should be invalid?"
    end
  end

  test "email should be unique and case insentive" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?, "Save the chef with duplicity"
  end

  test "email should be lowercase before hiting db" do
    mixed_email = "JoHn@EXample.COm"
    @chef.email = mixed_email
    @chef.save
    assert @chef.valid?, "Saved the mixed email"
  end

  test "password should be presente" do
    @chef.password = @chef.password_confirmation = " "
    assert_not @chef.valid?
  end

  test "password should not be too short less than 8" do
    @chef.password = @chef.password_confirmation = "a" * 7
    assert_not @chef.valid?
  end

  test "password should not be too long more than 72" do
    @chef.password = @chef.password_confirmation = "a" * 73
    assert_not @chef.valid?
  end

  test "password and password_confirmation must be igual" do
    @chef.password = "a" * 8
    @chef.password_confirmation = "a" * 9
    assert_not @chef.valid?
  end

  test "associated recipes must be destroy" do
    @chef.save
    @chef.recipes.create!(name: "testing destroy", description: "testing destroy function")
    assert_difference 'Recipe.count', -1 do
      @chef.destroy
    end
  end
end
