require 'test_helper'

class UnblockSiteControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get unblock_site_index_url
    assert_response :success
  end

end
