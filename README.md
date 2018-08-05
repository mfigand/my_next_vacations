# my_next_vacations_api
Code challenge for CartoDB

Installation
------------

##  Requirements

* Ruby version 2.5.0
* Rails version 5.2.0
* MongoDB server up and running

##  Configuration

* Execute 'bundle install' to install gems

* Execute 'rake db:create' to create development Database

* Execute 'RAILS_ENV=test rake db:create' to create test Database

* Execute 'rails s' to launch a web server to access the application through http://0.0.0.0:3000 host

## How to run the test suite

* bin/rails test


Features
--------

## 1. Load the provided activities file (madrid.json)

* When starts the rails server the config/initializers/seed_db.rb file loads the data from db/seeds.rb

* The db/seeds.rb file load public/files/madrid.json file and populates Database creating available activities in GeoJSON format.


## 2. Create an endpoint that returns all available activities

* The endpoint '/available_activities' return all information about the available activities, in GeoJSON format

* You can filter by category, location or district passing a filter through this endpoints:

  - get '/available_activities/category/:category'

  - get '/available_activities/location/:location'

  - get '/available_activities/district/:district'

*  If no filter is provided, it list all activities:

  - get '/available_activities'

## 3. Create an endpoint to recommend what to do at a given time

* The endpoint '/available_activities/category/:category/between/:opening_hours' receives a time range (in this format '09:00-15:00') that the vacation-goer has available to perform an activity and the preferred category (like this 'nature')

* And return a single activity and all its details, in GeoJSON format, that belong to the specified category and be open to the public at the time of visit.

* If there are multiple options, return the one with the longest visit time that fits in the time range.


## 4. Future extended functionality

### Do not recommend an outdoors activity on a rainy day

To implement this features we could integrate a third party API like openweathermap.org were we can send the latitud and longitud and recive wheather information.

As an example we can parse latitud and longitud from our model AvailableActivit.geometry["coordinates"] and make the API call like this api.openweathermap.org/data/2.5/weather?lat=35&lon=139. Then from the response we can make conditions to recommend or not this activity.

To integrate third party APIs to our rails app we could use gem 'dotenv-rails' and gem 'faraday'. We need dotenv-rails, to keep the API token as an environment variable, and faraday to make requests to Spoonacular API.


### Support getting information about activities in multiple cities

* Create other endpoint that receives as parameter multiple cities coordinates:

  - get '/available_activities/multi_coordenates/:multi_coordenates'

* And other endpoint that receives as parameter multiple cities names:

  - get '/available_activities/multi_city/:multi_city'

This way allows the user to filter activities by coordinates or by name.

The response will be all the available_activities that math this parameters and will be deliver in GeoJSON format.


### Extend the recommendation API to fill the given time range with multiple activities

* We could add an optional parameter to the recommendation endpoint like this:

  - get '/available_activities/category/:category/between/:opening_hours/all/:all'

Then if user pass this param as true (:all => true) the response will return ALL available_activities that match conditions instead of return only the activity with the longest visit time


Author
------

Original author: Manuel Figueroa Andrade


License
-------

(The MIT License) FIXME (different license?)

Copyright (c) 2018 FIXME (author's name)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
