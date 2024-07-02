require "test_helper"

class AdminUserDetailControllerTest < ActionDispatch::IntegrationTest
  test "should get page" do
    get admin_user_detail_page_url
    assert_response :success
  end

  test "should get view_user" do
    get admin_user_detail_view_user_url
    assert_response :success
  end

  test "should get edit_user" do
    get admin_user_detail_edit_user_url
    assert_response :success
  end

  test "should get post_edit_user" do
    get admin_user_detail_post_edit_user_url
    assert_response :success
  end
end
