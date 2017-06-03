require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", curation_path
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", login_path
  end
end
