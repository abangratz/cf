require 'test_helper'

class Administration::CharactersControllerTest < ActionController::TestCase
  setup do
    @administration_character = administration_characters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administration_characters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administration_character" do
    assert_difference('Administration::Character.count') do
      post :create, :administration_character => @administration_character.attributes
    end

    assert_redirected_to administration_character_path(assigns(:administration_character))
  end

  test "should show administration_character" do
    get :show, :id => @administration_character.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @administration_character.to_param
    assert_response :success
  end

  test "should update administration_character" do
    put :update, :id => @administration_character.to_param, :administration_character => @administration_character.attributes
    assert_redirected_to administration_character_path(assigns(:administration_character))
  end

  test "should destroy administration_character" do
    assert_difference('Administration::Character.count', -1) do
      delete :destroy, :id => @administration_character.to_param
    end

    assert_redirected_to administration_characterses_path
  end
end
