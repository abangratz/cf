require 'test_helper'

class Administration::ProfilesControllerTest < ActionController::TestCase
  setup do
    @administration_profile = administration_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administration_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administration_profile" do
    assert_difference('Administration::Profile.count') do
      post :create, :administration_profile => @administration_profile.attributes
    end

    assert_redirected_to administration_profile_path(assigns(:administration_profile))
  end

  test "should show administration_profile" do
    get :show, :id => @administration_profile.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @administration_profile.to_param
    assert_response :success
  end

  test "should update administration_profile" do
    put :update, :id => @administration_profile.to_param, :administration_profile => @administration_profile.attributes
    assert_redirected_to administration_profile_path(assigns(:administration_profile))
  end

  test "should destroy administration_profile" do
    assert_difference('Administration::Profile.count', -1) do
      delete :destroy, :id => @administration_profile.to_param
    end

    assert_redirected_to administration_profileses_path
  end
end
