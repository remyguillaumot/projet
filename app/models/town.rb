class Town < ActiveRecord::Base
  validates :name, :postCode, :latitude, :longitude, presence: true
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
end
