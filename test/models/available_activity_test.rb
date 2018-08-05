require 'test_helper'

class AvailableActivityTest < ActiveSupport::TestCase

  test "should transform '9:00-15:00' to time range format" do
    range = "9:00-15:00"
    assert_instance_of(Range, AvailableActivity.get_range(range))
  end

  test "should cover search_range + activity hours_spent" do
    opening_hours = "10:00".to_time.."18:00".to_time
    search_range = "11:00".to_time.."13:00".to_time
    hours_spent = 2
    assert AvailableActivity.match_opening_hours?(opening_hours,search_range,hours_spent)
  end

  test "should not cover search_range + activity hours_spent" do
    opening_hours = "10:00".to_time.."18:00".to_time
    search_range = "17:00".to_time.."19:00".to_time
    hours_spent = 2

    assert_not AvailableActivity.match_opening_hours?(opening_hours,search_range,hours_spent)
  end

  test "should return all activities with matching category" do
    params = {"category"=>"shopping"}
    assert_equal( "shopping", AvailableActivity.filter_with(params).first["properties"]["category"] )
  end

  test "should return all activities with matching location" do
    params = {"location"=>"outdoors"}
    assert_equal( "outdoors", AvailableActivity.filter_with(params).first["properties"]["location"] )
  end

  test "should return all activities with matching district" do
    params = {"district"=>"centro"}
    assert_equal( "centro", AvailableActivity.filter_with(params).first["properties"]["district"] )
  end

end
