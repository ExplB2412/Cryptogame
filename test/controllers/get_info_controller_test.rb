require "test_helper"

class GetInfoControllerTest < ActionDispatch::IntegrationTest
  test "should get info_user" do
    get get_info_info_user_url
    assert_response :success
  end
end
