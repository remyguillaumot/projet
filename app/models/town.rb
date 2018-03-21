require 'forecast_io'
ForecastIO.configure do |configuration|
  configuration.api_key = 'ca2972588bcbf366b699fc1db63ab2c6'
end

class Town < ActiveRecord::Base
  validates :name,:latitude, :longitude, presence: true
  before_validation :geocode
  
  private
  def geocode
    towns = Nominatim.search.city(self.name).limit(1).address_details(true)
    if towns && towns.first
      current_town = towns.first
      self.postCode = current_town.address.postcode
      self.latitude = current_town.lat
      self.longitude = current_town.lon
    end
  end
  
  public
  def get_weather
    weather = ForecastIO.forecast(self.latitude,self.longitude, params: {units: 'si', lang: 'fr' }).currently
    if weather
      return weather
    end
  end
end
