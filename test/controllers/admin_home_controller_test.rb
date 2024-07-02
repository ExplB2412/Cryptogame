require "test_helper"

class AdminHomeControllerTest < ActionDispatch::IntegrationTest
  test "should get page" do
    get admin_home_page_url
    assert_response :success
  end

  test "should get get_full" do
    get admin_home_get_full_url
    assert_response :success
  end

  test "should get searching_time" do
    get admin_home_searching_time_url
    assert_response :success
  end
end
