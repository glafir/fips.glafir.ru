require 'test_helper'

class TzRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tz_request = tz_requests(:one)
  end

  test "should get index" do
    get tz_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_tz_request_url
    assert_response :success
  end

  test "should create tz_request" do
    assert_difference('TzRequest.count') do
      post tz_requests_url, params: { tz_request: { date_start: @tz_request.date_start, doc: @tz_request.doc, img: @tz_request.img, org_id: @tz_request.org_id } }
    end

    assert_redirected_to tz_request_url(TzRequest.last)
  end

  test "should show tz_request" do
    get tz_request_url(@tz_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_tz_request_url(@tz_request)
    assert_response :success
  end

  test "should update tz_request" do
    patch tz_request_url(@tz_request), params: { tz_request: { date_start: @tz_request.date_start, doc: @tz_request.doc, img: @tz_request.img, org_id: @tz_request.org_id } }
    assert_redirected_to tz_request_url(@tz_request)
  end

  test "should destroy tz_request" do
    assert_difference('TzRequest.count', -1) do
      delete tz_request_url(@tz_request)
    end

    assert_redirected_to tz_requests_url
  end
end
