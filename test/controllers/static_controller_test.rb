require 'test_helper'

class StaticControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get aboutme" do
    get :aboutme
    assert_response :success
  end

  test "should get blog" do
    get :blog
    assert_response :success
  end

  test "should get resume" do
    get :resume
    assert_response :success
  end

  test "should get projects" do
    get :resume
    assert_response :success
  end

end
