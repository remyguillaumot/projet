class Town < ActiveRecord::Base
  validates :name, :latitude, :longitude, presence: true
  before_validation :geocode
  
  private
  def geocode
    towns = Nominatim.search.city(self.name).limit(1)
    if towns && towns.first
      current_town = towns.first
      self.latitude = current_town.lat
      self.longitude = current_town.lon
    end
  end
end
