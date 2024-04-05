require 'test_helper'

class WeatherServiceTest < ActiveSupport::TestCase

  test "call with known parameters" do
    # Example address is 1138 S Stanley Ave, LA
    latitude = 34.05486
    longitude = -118.35922
    weather = WeatherService.call(latitude, longitude)
    assert_includes -4..44, weather.temperature
    assert_includes -4..44, weather.temperature_min
    assert_includes -4..44, weather.temperature_max
    refute_empty weather.description
  end

end