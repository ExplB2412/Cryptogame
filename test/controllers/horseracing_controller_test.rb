require "test_helper"

class HorseracingControllerTest < ActionDispatch::IntegrationTest
  test "should get page" do
    get horseracing_page_url
    assert_response :success
  end

  test "should get racing" do
    get horseracing_racing_url
    assert_response :success
  end

  test "should get result" do
    get horseracing_result_url
    assert_response :success
  end
end
