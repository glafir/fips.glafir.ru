require 'test_helper'

class OrgAddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @org_address = org_addresses(:one)
  end

  test "should get index" do
    get org_addresses_url
    assert_response :success
  end

  test "should get new" do
    get new_org_address_url
    assert_response :success
  end

  test "should create org_address" do
    assert_difference('OrgAddress.count') do
      post org_addresses_url, params: { org_address: { address: @org_address.address, org_id: @org_address.org_id } }
    end

    assert_redirected_to org_address_url(OrgAddress.last)
  end

  test "should show org_address" do
    get org_address_url(@org_address)
    assert_response :success
  end

  test "should get edit" do
    get edit_org_address_url(@org_address)
    assert_response :success
  end

  test "should update org_address" do
    patch org_address_url(@org_address), params: { org_address: { address: @org_address.address, org_id: @org_address.org_id } }
    assert_redirected_to org_address_url(@org_address)
  end

  test "should destroy org_address" do
    assert_difference('OrgAddress.count', -1) do
      delete org_address_url(@org_address)
    end

    assert_redirected_to org_addresses_url
  end
end
