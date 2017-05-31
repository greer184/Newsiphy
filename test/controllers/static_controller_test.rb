require 'test_helper'

class StaticControllerTest < ActionDispatch::IntegrationTest
 
  test "about page available" do
    get static_about_url
    assert_response :success
  end

  test "curation page available" do
    get static_curation_url
    assert_response :success
  end

end
