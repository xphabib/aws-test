require 'test_helper'

class PublicPhotosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_photos_index_url
    assert_response :success
  end

end
