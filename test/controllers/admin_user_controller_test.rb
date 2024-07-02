require "test_helper"

class AdminUserControllerTest < ActionDispatch::IntegrationTest
  test "should get page" do
    get admin_user_page_url
    assert_response :success
  end

  test "should get view_user" do
    get admin_user_view_user_url
    assert_response :success
  end

  test "should get edit_user" do
    get admin_user_edit_user_url
    assert_response :success
  end

  test "should get post_edit_user" do
    get admin_user_post_edit_user_url
    assert_response :success
  end
end
