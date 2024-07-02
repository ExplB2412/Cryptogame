require "test_helper"

class WithdrawControllerTest < ActionDispatch::IntegrationTest
  test "should get page" do
    get withdraw_page_url
    assert_response :success
  end

  test "should get with_request" do
    get withdraw_with_request_url
    assert_response :success
  end

  test "should get check" do
    get withdraw_check_url
    assert_response :success
  end
end
