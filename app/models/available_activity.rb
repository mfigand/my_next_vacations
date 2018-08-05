class AvailableActivity
  include Mongoid::Document
  field :type, type: String
  field :geometry, type: Hash
  field :properties, type: Hash

  validates_presence_of :type, :geometry, :properties

  def self.filter_with(params)
    key = params.keys.first
    if key == "opening_hours"
      day = ["mo", "tu", "we", "th", "fr", "sa", "su"][Date.today.wday-1]
      # TODO filter with opening_hours not null
      filtered_activities = self.where(
                                  "properties.category" => params[:category]
                                ).desc('properties.hours_spent')
      # TODO improve query with a mapper instead of select
      filtered_activities.select { |a|
        if a.properties[key][day].any?
          opening_hours = get_range(a.properties[key][day].first)
          search_range = get_range(params[key])
          @max_hours_spent_activity = a if match_opening_hours?(opening_hours, search_range, a.properties[:hours_spent])
          break if @max_hours_spent_activity.present?
        end
      } if filtered_activities.any?

      @max_hours_spent_activity
    else
      filtered_activities = self.where("properties.#{key}" => params[key])
    end
  end

  def self.match_opening_hours?(opening_hours,search_range,hours_spent)
    from = search_range.first
    to = search_range.last
    return false if opening_hours.last == from
    return false if opening_hours.first == to
    (opening_hours.cover?(from) && opening_hours.cover?(from+hours_spent.hour)) ||
    (opening_hours.cover?(to) && opening_hours.cover?(to+hours_spent.hour))
  end

  def self.get_range(hour_range)
    range_array = hour_range.split('-')
    open_time = range_array.first.to_time
    close_time = range_array.last.to_time
    open_time..close_time
  end

end
