require 'test_helper'

class PagesTest < ActionDispatch::IntegrationTest

  test "should get home" do
    get root_url
    assert_response :success
  end



end
