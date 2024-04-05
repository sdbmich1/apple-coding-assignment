require 'test_helper'

class GeocodeServiceTest < ActiveSupport::TestCase

  test "call with known address" do
    address = "1138 S Stanley Ave, LA, CA"
    geocode = GeocodeService.call(address)
    assert_in_delta 34.05, geocode.latitude, 0.1
    assert_in_delta -118.35, geocode.longitude, 0.1
    assert_equal "us", geocode.country_code
    assert_equal "90019", geocode.postal_code
  end
end
