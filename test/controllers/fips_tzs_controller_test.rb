require 'test_helper'

class FipsTzsControllerTest < ActionController::TestCase
  setup do
    @fips_tz = fips_tzs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fips_tzs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fips_tz" do
    assert_difference('FipsTz.count') do
      post :create, fips_tz: { doc: @fips_tz.doc, tz_n: @fips_tz.tz_n, url_string_fips: @fips_tz.url_string_fips }
    end

    assert_redirected_to fips_tz_path(assigns(:fips_tz))
  end

  test "should show fips_tz" do
    get :show, id: @fips_tz
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fips_tz
    assert_response :success
  end

  test "should update fips_tz" do
    patch :update, id: @fips_tz, fips_tz: { doc: @fips_tz.doc, tz_n: @fips_tz.tz_n, url_string_fips: @fips_tz.url_string_fips }
    assert_redirected_to fips_tz_path(assigns(:fips_tz))
  end

  test "should destroy fips_tz" do
    assert_difference('FipsTz.count', -1) do
      delete :destroy, id: @fips_tz
    end

    assert_redirected_to fips_tzs_path
  end
end
