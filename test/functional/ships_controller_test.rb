require 'test_helper'

class ShipsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:ships)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_ship
    assert_difference('Ship.count') do
      post :create, :ship => { }
    end

    assert_redirected_to ship_path(assigns(:ship))
  end

  def test_should_show_ship
    get :show, :id => ships(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => ships(:one).id
    assert_response :success
  end

  def test_should_update_ship
    put :update, :id => ships(:one).id, :ship => { }
    assert_redirected_to ship_path(assigns(:ship))
  end

  def test_should_destroy_ship
    assert_difference('Ship.count', -1) do
      delete :destroy, :id => ships(:one).id
    end

    assert_redirected_to ships_path
  end
end
