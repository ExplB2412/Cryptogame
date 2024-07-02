require "test_helper"

class AdminPaymentWithdrawControllerTest < ActionDispatch::IntegrationTest
  test "should get page" do
    get admin_payment_withdraw_page_url
    assert_response :success
  end

  test "should get view_withdraw" do
    get admin_payment_withdraw_view_withdraw_url
    assert_response :success
  end

  test "should get update_withdraw" do
    get admin_payment_withdraw_update_withdraw_url
    assert_response :success
  end

  test "should get delete_withdraw" do
    get admin_payment_withdraw_delete_withdraw_url
    assert_response :success
  end

  test "should get edit_withdraw" do
    get admin_payment_withdraw_edit_withdraw_url
    assert_response :success
  end

  test "should get cancel_withdraw" do
    get admin_payment_withdraw_cancel_withdraw_url
    assert_response :success
  end

  test "should get accept_withdraw" do
    get admin_payment_withdraw_accept_withdraw_url
    assert_response :success
  end
end
