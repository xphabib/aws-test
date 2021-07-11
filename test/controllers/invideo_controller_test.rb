require 'test_helper'

class InvideoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get invideo_index_url
    assert_response :success
  end

end
