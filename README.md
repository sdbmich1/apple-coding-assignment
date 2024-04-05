# README

This README would normally document whatever steps are necessary to get the
application up and running.

```ruby
uses rvm to install ruby

* Rails version : 6.1.7
* Ruby version : 3.2.3
```

* System dependencies
Uses faraday gem
Weather API from openweather.org
Geocoder gem

* Configuration
rails dev:cache to enable cache in development

* Database creation (needs to run for test suite)
rails db:create

* Database initialization
rails db:migrate

* How to run the test suite - uses Minitest
rake db:test:prepare
rake test - will run all tests for forecasts controller and services 

```Services (job queues, cache servers, search engines, etc.)
Uses Rails cache to cache API call
geocoder_service.rb: geocode the given address to get the lat/long data
weather_service.rb: calls WeatherAPI from openweather.org to get weather info
```

* Deployment instructions
rails server - visit 127.0.0.1:3000 or localhost:3000

