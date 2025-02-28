class Ride < ApplicationRecord
  validates :day, :date, :passenger_name_and_phone, presence: true

  def self.filtered_rides(driver_name)
    rides = where(date: Time.zone.today)
    rides = rides.where("driver LIKE ?", "%#{driver_name}%") if driver_name.present?
    rides
  end
end
