require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get get_info" do
    get user_get_info_url
    assert_response :success
  end
end
