require 'test_helper'

class PublicAudioControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_audio_index_url
    assert_response :success
  end

end
