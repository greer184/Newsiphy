require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "should reject invalid signup" do
    get signup_path
    assert_no_difference 'User.count' do 
      post users_path, params: { user: { name: "",
                                         email: "user@example",
                                         password: "blue",
                                         password_confirmation: "tooth"}}
    end
    assert_template 'users/new'
  end

  test "should accept valid user" do
    get signup_path
   # assert_difference 'User.count', 1 do
    #  post users_path, params: { user: { name: "Test",
     #                                    email: "testyes@example.com",
      #                                   password: "testyes123",
       #                                  password_confirmation: "testyes123"}}
   # end
  #  follow_redirect!
 #   assert_template 'entries/index'
    #assert logged_in?
  end

end
