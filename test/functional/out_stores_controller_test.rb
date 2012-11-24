require 'test_helper'

class OutStoresControllerTest < ActionController::TestCase
  setup do
    @out_store = out_stores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:out_stores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create out_store" do
    assert_difference('OutStore.count') do
      post :create, out_store: { caption: @out_store.caption }
    end

    assert_redirected_to out_store_path(assigns(:out_store))
  end

  test "should show out_store" do
    get :show, id: @out_store
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @out_store
    assert_response :success
  end

  test "should update out_store" do
    put :update, id: @out_store, out_store: { caption: @out_store.caption }
    assert_redirected_to out_store_path(assigns(:out_store))
  end

  test "should destroy out_store" do
    assert_difference('OutStore.count', -1) do
      delete :destroy, id: @out_store
    end

    assert_redirected_to out_stores_path
  end
end
