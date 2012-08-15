require 'test_helper'

class UnpaidDebtsControllerTest < ActionController::TestCase
  setup do
    @unpaid_debt = unpaid_debts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:unpaid_debts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create unpaid_debt" do
    assert_difference('UnpaidDebt.count') do
      post :create, unpaid_debt: { caption: @unpaid_debt.caption, money: @unpaid_debt.money, status: @unpaid_debt.status }
    end

    assert_redirected_to unpaid_debt_path(assigns(:unpaid_debt))
  end

  test "should show unpaid_debt" do
    get :show, id: @unpaid_debt
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @unpaid_debt
    assert_response :success
  end

  test "should update unpaid_debt" do
    put :update, id: @unpaid_debt, unpaid_debt: { caption: @unpaid_debt.caption, money: @unpaid_debt.money, status: @unpaid_debt.status }
    assert_redirected_to unpaid_debt_path(assigns(:unpaid_debt))
  end

  test "should destroy unpaid_debt" do
    assert_difference('UnpaidDebt.count', -1) do
      delete :destroy, id: @unpaid_debt
    end

    assert_redirected_to unpaid_debts_path
  end
end
