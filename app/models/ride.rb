class Ride < ApplicationRecord
  validates :day, :date, :passenger_name_and_phone, presence: true

  def self.today_rides(rides)
    rides.where(date: Time.zone.today)
  end

  def self.rides_by_driver(rides, driver_name)
    rides = rides.where("driver LIKE ?", "%#{driver_name}%") if driver_name.present?
    rides
  end

  def self.filtered_rides(driver_name)
    self.rides_by_driver(self.today_rides(Ride.all), driver_name)
  end
end
