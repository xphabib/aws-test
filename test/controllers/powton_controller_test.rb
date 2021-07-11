require 'test_helper'

class PowtonControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get powton_index_url
    assert_response :success
  end

  test "should get download" do
    get powton_download_url
    assert_response :success
  end

end
