require 'test_helper'

class FlexclipControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get flexclip_index_url
    assert_response :success
  end

end
