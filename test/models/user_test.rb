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

  test "should reject if name not present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "should reject if email not present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "should reject invalid name length" do
    @user.name = "A" * 51
    assert_not @user.valid?
  end

  test "should reject invalid email length" do
    @user.name = "A" * 113 + "@newiphy.com"
    assert_not @user.valid?
  end

  test "should reject invalid emails" do
    addresses = %w[user@example,com user_at_example.com user.name@example.
                   user@example_news.com user@example+news.com 
                   user@example..com]
    addresses.each do |ad|
      @user.email = ad
      assert_not @user.valid?, "#{ad.inspect} should be invalid"
    end
  end

  test "should reject duplicate emails" do
    user2 = @user.dup
    user2.email = @user.email.upcase
    @user.save
    assert_not user2.valid?
  end

  test "should save emails undercase" do
    email = "USER@EXAMPLE.COM"
    @user.email = email
    @user.save
    assert_equal email.downcase, @user.reload.email
  end

  test "should reject if password is not present" do
    @user.password = @user.password_confirmation = "   "
    assert_not @user.valid?
  end

  test "should reject invalid password length" do
    @user.password = @user.password_confirmation = "123456"
    assert_not @user.valid?
  end

  test "should reject if password confirmation not present" do
    @user.password_confirmation = "    "
    assert_not @user.valid?
  end


end
