require 'test_helper'

class AvailableActivitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # @available_activity = available_activities(:one)
    @available_activity = AvailableActivity.first
  end

  test "should get index" do
    get available_activities_url, as: :json
    assert_response :success
  end

  test "should get filtered activities by category" do
    get activities_by_category_url("shopping"), as: :json
    assert_response :success
    assert_equal( "shopping", JSON.parse(response.body).first["properties"]["category"] )
  end

  test "should get filtered activities by location" do
    get activities_by_location_url("outdoors"), as: :json
    assert_response :success
    assert_equal( "outdoors", JSON.parse(response.body).first["properties"]["location"] )
  end

  test "should get filtered activities by district" do
    get activities_by_district_url("centro"), as: :json
    assert_response :success
    assert_equal( "centro", JSON.parse(response.body).first["properties"]["district"] )
  end

  test "should return the activity with the longest visit time filtered by category between time range" do
    get activity_between_url("shopping","9:00-14:00"), as: :json
    assert_response :success
    activity_response = JSON.parse(response.body)
    assert_equal( "shopping", activity_response["properties"]["category"] )

    day = ["mo", "tu", "we", "th", "fr", "sa", "su"][Date.today.wday-1]
    opening_hours = AvailableActivity.get_range(activity_response["properties"]["opening_hours"][day].first)
    search_range = AvailableActivity.get_range("9:00-14:00")
    assert(AvailableActivity.match_opening_hours?(opening_hours,search_range,activity_response["properties"]["hours_spent"]))
  end

  test "should create available_activity" do
    assert_difference('AvailableActivity.count') do
      post available_activities_url, params: { available_activity: { geometry: @available_activity.geometry, properties: @available_activity.properties, type: @available_activity.type } }, as: :json
    end

    assert_response 201
  end

  test "should show available_activity" do
    get available_activity_url(@available_activity), as: :json
    assert_response :success
  end

  test "should update available_activity" do
    patch available_activity_url(@available_activity), params: { available_activity: { geometry: @available_activity.geometry, properties: @available_activity.properties, type: @available_activity.type } }, as: :json
    assert_response 200
  end

  test "should destroy available_activity" do
    assert_difference('AvailableActivity.count', -1) do
      delete available_activity_url(@available_activity), as: :json
    end

    assert_response 204
  end
end
