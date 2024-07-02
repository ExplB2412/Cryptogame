require "test_helper"

class AdminLoginControllerTest < ActionDispatch::IntegrationTest
  test "should get page" do
    get admin_login_page_url
    assert_response :success
  end

  test "should get login" do
    get admin_login_login_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_login_destroy_url
    assert_response :success
  end
end
