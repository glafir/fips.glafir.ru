require 'test_helper'

class OrgTelefphonesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @org_telefphone = org_telefphones(:one)
  end

  test "should get index" do
    get org_telefphones_url
    assert_response :success
  end

  test "should get new" do
    get new_org_telefphone_url
    assert_response :success
  end

  test "should create org_telefphone" do
    assert_difference('OrgTelefphone.count') do
      post org_telefphones_url, params: { org_telefphone: { org_id: @org_telefphone.org_id, telephone: @org_telefphone.telephone } }
    end

    assert_redirected_to org_telefphone_url(OrgTelefphone.last)
  end

  test "should show org_telefphone" do
    get org_telefphone_url(@org_telefphone)
    assert_response :success
  end

  test "should get edit" do
    get edit_org_telefphone_url(@org_telefphone)
    assert_response :success
  end

  test "should update org_telefphone" do
    patch org_telefphone_url(@org_telefphone), params: { org_telefphone: { org_id: @org_telefphone.org_id, telephone: @org_telefphone.telephone } }
    assert_redirected_to org_telefphone_url(@org_telefphone)
  end

  test "should destroy org_telefphone" do
    assert_difference('OrgTelefphone.count', -1) do
      delete org_telefphone_url(@org_telefphone)
    end

    assert_redirected_to org_telefphones_url
  end
end
