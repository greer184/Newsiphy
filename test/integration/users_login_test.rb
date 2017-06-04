require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:william)
  end

  test "should reject login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" }}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "should accept valid login" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'imightjustbeagod' }}
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'entries/index'
    #Need to update this test when relevant
    #assert_select "a[href=?]", login_path, count: 0
    #assert_select "a[href=?]", logout_path
  end

end
