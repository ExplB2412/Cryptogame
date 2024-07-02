require "test_helper"

class TicketControllerTest < ActionDispatch::IntegrationTest
  test "should get page" do
    get ticket_page_url
    assert_response :success
  end

  test "should get get_ticket" do
    get ticket_get_ticket_url
    assert_response :success
  end

  test "should get post_ticket" do
    get ticket_post_ticket_url
    assert_response :success
  end
end
