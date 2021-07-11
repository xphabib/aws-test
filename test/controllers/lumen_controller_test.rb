require 'test_helper'

class LumenControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lumen_index_url
    assert_response :success
  end

end
