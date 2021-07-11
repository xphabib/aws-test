require 'test_helper'

class ApkDownloadControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get apk_download_index_url
    assert_response :success
  end

end
