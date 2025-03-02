class Ride < ApplicationRecord
  validates :day, :date, :passenger_name_and_phone, presence: true

  scope :today, -> { where(date: Date.today) } 

  scope :filter_by_driver, ->(driver_name) {
    where("driver LIKE ?", "%#{driver_name}%") if driver_name.present?
  }

  def self.filtered_rides(driver_name)
    today.filter_by_driver(driver_name)
  end

  def self.filter_rides(filter_params)
    rides = Ride.all

    if filter_params[:destination].present?
      destination = filter_params[:destination]
      rides = rides.where("LOWER(destination) LIKE ?", "%#{destination.downcase}%")
    end 

    if filter_params[:date_start].present?
      date_start = Date.parse(filter_params[:date_start])
      rides = rides.where("date >= ?", date_start) if date_start
    end 

    if filter_params[:date_end].present?
      date_end = Date.parse(filter_params[:date_end])
    else 
      date_end = Date.today
    end 
    rides = rides.where("date <= ?", date_end) if date_end

    rides = rides.where(van: filter_params[:van].presence) if filter_params[:van].present?
    rides = rides.where(destination: filter_params[:destination].presence) if filter_params[:destination].present?

    rides
  end 







end
