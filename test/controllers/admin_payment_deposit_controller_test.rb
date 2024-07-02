require "test_helper"

class AdminPaymentDepositControllerTest < ActionDispatch::IntegrationTest
  test "should get page" do
    get admin_payment_deposit_page_url
    assert_response :success
  end

  test "should get view_deposit" do
    get admin_payment_deposit_view_deposit_url
    assert_response :success
  end

  test "should get update_deposit" do
    get admin_payment_deposit_update_deposit_url
    assert_response :success
  end

  test "should get delete_deposit" do
    get admin_payment_deposit_delete_deposit_url
    assert_response :success
  end

  test "should get edit_deposit" do
    get admin_payment_deposit_edit_deposit_url
    assert_response :success
  end

  test "should get cancel_deposit" do
    get admin_payment_deposit_cancel_deposit_url
    assert_response :success
  end
end
