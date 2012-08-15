require 'test_helper'

class InComesControllerTest < ActionController::TestCase
  setup do
    @in_come = in_comes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:in_comes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create in_come" do
    assert_difference('InCome.count') do
      post :create, in_come: { mode: @in_come.mode, money: @in_come.money, payer: @in_come.payer }
    end

    assert_redirected_to in_come_path(assigns(:in_come))
  end

  test "should show in_come" do
    get :show, id: @in_come
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @in_come
    assert_response :success
  end

  test "should update in_come" do
    put :update, id: @in_come, in_come: { mode: @in_come.mode, money: @in_come.money, payer: @in_come.payer }
    assert_redirected_to in_come_path(assigns(:in_come))
  end

  test "should destroy in_come" do
    assert_difference('InCome.count', -1) do
      delete :destroy, id: @in_come
    end

    assert_redirected_to in_comes_path
  end
end
