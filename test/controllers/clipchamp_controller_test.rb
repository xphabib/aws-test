require 'test_helper'

class ClipchampControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get clipchamp_index_url
    assert_response :success
  end

end
