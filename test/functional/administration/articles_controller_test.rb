require 'test_helper'

class Administration::ArticlesControllerTest < ActionController::TestCase
  setup do
    @administration_article = administration_articles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administration_articles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administration_article" do
    assert_difference('Administration::Article.count') do
      post :create, :administration_article => @administration_article.attributes
    end

    assert_redirected_to administration_article_path(assigns(:administration_article))
  end

  test "should show administration_article" do
    get :show, :id => @administration_article.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @administration_article.to_param
    assert_response :success
  end

  test "should update administration_article" do
    put :update, :id => @administration_article.to_param, :administration_article => @administration_article.attributes
    assert_redirected_to administration_article_path(assigns(:administration_article))
  end

  test "should destroy administration_article" do
    assert_difference('Administration::Article.count', -1) do
      delete :destroy, :id => @administration_article.to_param
    end

    assert_redirected_to administration_articles_path
  end
end
