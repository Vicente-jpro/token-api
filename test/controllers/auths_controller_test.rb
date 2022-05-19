require "test_helper"

class AuthsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get auths_create_url
    assert_response :success
  end
end
