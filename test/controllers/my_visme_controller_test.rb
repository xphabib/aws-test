require 'test_helper'

class MyVismeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_visme_index_url
    assert_response :success
  end

end
