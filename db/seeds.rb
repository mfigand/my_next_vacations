# For this exercise we reset Data Base to work only with example activities
AvailableActivity.all.destroy

available_activities = JSON.parse(File.read(Rails.root.join('public/files/madrid.json')))

available_activities.map{|activity|
  AvailableActivity.create(
    "type": "Feature",
    "geometry": {
      "type": "Point",
      "coordinates": activity["latlng"]
    },
    "properties": {
      "name": activity["name"],
      "opening_hours": activity["opening_hours"],
      "hours_spent": activity["hours_spent"],
      "category": activity["category"].downcase,
      "location": activity["location"].downcase,
      "district": activity["district"].downcase
    }
  )
}
