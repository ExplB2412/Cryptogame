require "test_helper"

class ScratchGameControllerTest < ActionDispatch::IntegrationTest
  test "should get page" do
    get scratch_game_page_url
    assert_response :success
  end

  test "should get buy" do
    get scratch_game_buy_url
    assert_response :success
  end

  test "should get scratch" do
    get scratch_game_scratch_url
    assert_response :success
  end
end
