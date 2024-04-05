##################################################################
#
# Name: weather_service.rb
#
# Purpose:  Calls external WeatherMap API as needed and return forecast results
#
# Uses Faraday to make API call and checks response for errors
#
# Params:   latitude
#           longitude
#
# Returns: Struct/Hash
#
###################################################################
class WeatherService < ApplicationService

  API_KEY = "9fc78f29591f9d76356f9895266b276f".freeze

  def self.call(latitude, longitude)
    conn = Faraday.new("https://api.openweathermap.org") do |f|
      f.request :json # encode req bodies as JSON and automatically set the Content-Type header
      f.request :retry # retry transient failures
      f.response :json # decode response bodies as JSON
    end    
    response = conn.get('/data/2.5/weather', {
      appid: API_KEY,
      lat: latitude,
      lon: longitude,
      units: "metric",
    })

    # load response and check for errors
    body = response.body
    body or raise IOError.new "OpenWeather response body failed"
    body["main"] or raise IOError.new "OpenWeather main section is missing"
    body["main"]["temp"] or raise IOError.new "OpenWeather temperature is missing"
    body["main"]["temp_min"] or raise IOError.new "OpenWeather temperature minimum is missing"
    body["main"]["temp_max"] or raise IOError.new "OpenWeather temperature maximum is missing"
    body["weather"] or raise IOError.new "OpenWeather weather section is missing"
    body["weather"].length > 0 or raise IOError.new "OpenWeather weather section is empty"
    body["weather"][0]["description"] or raise IOError.new "OpenWeather weather description is missing"
    
    # return weather
    load_weather(body)
  end

  private


  def self.load_weather(body)
    weather = OpenStruct.new
    weather.temperature = body["main"]["temp"]
    weather.temperature_min = body["main"]["temp_min"]
    weather.temperature_max = body["main"]["temp_max"]
    weather.description = body["weather"][0]["description"]
    weather
  end
    
end