require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  include SessionHelper

  test "should create session on post login" do
    post :create,
         {
           session: {
             email:"test@test.fr",
             password:"test"
           }
         }
    assert logged_in?, "could login on post /login"
  end


  test "should not create session on wrong credentials" do
    #wrong password
    post :create,
         {
           session: {
             email:"test@test.fr",
             password:"wrongpassword"
           }
         }
    assert_not logged_in?, "could login on post /login without good password"

    #wrong email
    post :create,
         {
           session: {
             email:"ole@gmail.fr",
             password:"test"
           }
         }
    assert_not logged_in?, "could login on post /login without good email"

    #both wrong
    post :create,
         {
           session: {
             email:"ole@gmail.fr",
             password:"wrongpassword"
           }
         }
    assert_not logged_in?, "could login on post /login without good credentials"

    assert true, "couldn't login without good credentials"
  end

  test "should delete session on delete logout" do
    post :create,
         {
           session: {
             email:"test@test.fr",
             password:"test"
           }
         }
    if logged_in?
      delete :destroy
      assert_not logged_in?, "could logout after login"
    end
  end
end
