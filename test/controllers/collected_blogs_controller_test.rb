require 'test_helper'

class CollectedBlogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get collected_blogs_index_url
    assert_response :success
  end

end
