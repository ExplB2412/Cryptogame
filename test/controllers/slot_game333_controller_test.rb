require "test_helper"

class SlotGame333ControllerTest < ActionDispatch::IntegrationTest
  test "should get page" do
    get slot_game333_page_url
    assert_response :success
  end

  test "should get spin" do
    get slot_game333_spin_url
    assert_response :success
  end

  test "should get result" do
    get slot_game333_result_url
    assert_response :success
  end
end
