require "test_helper"

class DepositControllerTest < ActionDispatch::IntegrationTest
  test "should get page" do
    get deposit_page_url
    assert_response :success
  end

  test "should get notify" do
    get deposit_notify_url
    assert_response :success
  end

  test "should get success" do
    get deposit_success_url
    assert_response :success
  end

  test "should get fails" do
    get deposit_fails_url
    assert_response :success
  end

  test "should get check" do
    get deposit_check_url
    assert_response :success
  end

  test "should get deposit" do
    get deposit_deposit_url
    assert_response :success
  end
end
