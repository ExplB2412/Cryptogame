require "test_helper"

class UserInfoControllerTest < ActionDispatch::IntegrationTest
  test "should get page" do
    get user_info_page_url
    assert_response :success
  end

  test "should get change_password" do
    get user_info_change_password_url
    assert_response :success
  end
end
