require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com", 
                     password: "qwertyuiop",
                     password_confirmation: "qwertyuiop")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "should have name present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "should have email present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "should have valid name length" do
    @user.name = "A" * 51
    assert_not @user.valid?
  end

  test "should have valid email length" do
    @user.name = "A" * 113 + "@newiphy.com"
    assert_not @user.valid?
  end 

  test "should have valid password length" do
  end
end
