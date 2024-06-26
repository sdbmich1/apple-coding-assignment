##################################################################
#
# Name: geocode_service.rb
#
# Purpose:  Calls Geocoder to convert address to lat/long with zipcode as needed 
#
# Params:  address: string
#
# Returns: Struct/Hash
#
###################################################################
class GeocodeService < ApplicationService

  def self.call(address)
    response = Geocoder.search(address) # call geocoder

    # check response
    response or raise IOError.new "Geocoder error"
    response.length > 0 or raise IOError.new "Geocoder is empty: #{response}"

    # check response data
    data = response.first.data

    data or raise IOError.new "Geocoder data error"
    data["lat"] or raise IOError.new "Geocoder latitude is missing"
    data["lon"] or raise IOError.new "Geocoder longitude is missing"
    data["address"] or raise IOError.new "Geocoder address is missing" 
    data["address"]["country_code"] or raise IOError.new "Geocoder country code is missing"
    data["address"]["postcode"] or raise IOError.new "Geocoder postal code is missing" 
  
    # return geocode
    load_geocode(data)
  end

  private

  # return geocode data
  def self.load_geocode(data)
    geocode = OpenStruct.new
    geocode.latitude = data["lat"].to_f
    geocode.longitude = data["lon"].to_f
    geocode.country_code = data["address"]["country_code"]
    geocode.postal_code = data["address"]["postcode"]
    geocode
  end
end