require 'test_helper'

class ForumGroupsControllerTest < ActionController::TestCase
  setup do
    @forum_group = forum_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:forum_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create forum_group" do
    assert_difference('ForumGroup.count') do
      post :create, :forum_group => @forum_group.attributes
    end

    assert_redirected_to forum_group_path(assigns(:forum_group))
  end

  test "should show forum_group" do
    get :show, :id => @forum_group.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @forum_group.to_param
    assert_response :success
  end

  test "should update forum_group" do
    put :update, :id => @forum_group.to_param, :forum_group => @forum_group.attributes
    assert_redirected_to forum_group_path(assigns(:forum_group))
  end

  test "should destroy forum_group" do
    assert_difference('ForumGroup.count', -1) do
      delete :destroy, :id => @forum_group.to_param
    end

    assert_redirected_to forum_groups_path
  end
end
