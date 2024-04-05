##################################################################
#
# Forecasts controller
#
# Purpose:  Handles address input and checks cache to see if forecast has been run < 30 minutes for prior zip code if 
# so use cache else call API and cache result if zipcode was used 
#
# Params:  address: string
#
###################################################################
class ForecastsController < ApplicationController

  def show
    if params[:address]
      begin
        @address = params[:address]
        @geocode = GeocodeService.call(@address)
        @weather_cache_key = "#{@geocode.country_code}/#{@geocode.postal_code}"
        @weather_cache_exist = Rails.cache.exist?(@weather_cache_key)
        @weather = Rails.cache.fetch(@weather_cache_key, expires_in: 30.minutes) do
          WeatherService.call(@geocode.latitude, @geocode.longitude)  
          # Rails.cache.write(@weather_cache_key, @weather, expires_in: 30.minutes)        
        end
      rescue => e
        flash.alert = e.message
      end
    end
  end

end
