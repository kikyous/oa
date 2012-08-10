require 'test_helper'

class InStoresControllerTest < ActionController::TestCase
  setup do
    @in_store = in_stores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:in_stores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create in_store" do
    assert_difference('InStore.count') do
      post :create, in_store: { caption: @in_store.caption }
    end

    assert_redirected_to in_store_path(assigns(:in_store))
  end

  test "should show in_store" do
    get :show, id: @in_store
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @in_store
    assert_response :success
  end

  test "should update in_store" do
    put :update, id: @in_store, in_store: { caption: @in_store.caption }
    assert_redirected_to in_store_path(assigns(:in_store))
  end

  test "should destroy in_store" do
    assert_difference('InStore.count', -1) do
      delete :destroy, id: @in_store
    end

    assert_redirected_to in_stores_path
  end
end
