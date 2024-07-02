require "test_helper"

class InfoControllerTest < ActionDispatch::IntegrationTest
  test "should get deposit" do
    get info_deposit_url
    assert_response :success
  end

  test "should get withdraw" do
    get info_withdraw_url
    assert_response :success
  end

  test "should get update_info" do
    get info_update_info_url
    assert_response :success
  end
end
