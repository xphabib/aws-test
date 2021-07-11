require 'test_helper'

class YoutubeTagExtractorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get youtube_tag_extractor_index_url
    assert_response :success
  end

end
