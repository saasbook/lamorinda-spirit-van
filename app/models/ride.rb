class Ride < ApplicationRecord
  validates :day, :date, :passenger_name_and_phone, presence: true

  def self.today_rides(rides)
    rides.where(date: Time.zone.today)
  end

  def self.rides_by_driver(rides, driver_name)
    rides = rides.where("driver LIKE ?", "%#{driver_name}%") if driver_name.present?
    rides
  end

  # Filter rides by driver_name_text and driver_name_select
  # if driver_name_text and driver_name_select are present, return rides that match either driver_name_text OR driver_name_select
  # if driver_name_text is present, return rides that match driver_name_text
  # if driver_name_select is present, return rides that match driver_name_select
  # if neither driver_name_text nor driver_name_select are present, return all rides

  def self.filtered_rides(driver_name_text = nil, driver_name_select = nil)
    rides = today_rides(Ride.all)
    if driver_name_text.present? && driver_name_select.present?
      rides_text = rides_by_driver(rides, driver_name_text)
      rides_select = rides_by_driver(rides, driver_name_select)
      rides = rides_text.or(rides_select).distinct
    elsif driver_name_text.present?
      rides = rides_by_driver(rides, driver_name_text)
    elsif driver_name_select.present?
      rides = rides_by_driver(rides, driver_name_select)
    end
    rides
  end
end
