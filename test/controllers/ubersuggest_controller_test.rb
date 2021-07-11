require 'test_helper'

class UbersuggestControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ubersuggest_index_url
    assert_response :success
  end

end
