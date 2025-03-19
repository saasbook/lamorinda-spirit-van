# frozen_string_literal: true

class Ride < ApplicationRecord
  belongs_to :passenger, optional: true
  belongs_to :driver
  belongs_to :start_address, class_name: "Address", foreign_key: :start_address_id
  belongs_to :dest_address, class_name: "Address", foreign_key: :dest_address_id


  def self.rides_by_date(rides, date)
    rides.where(date: date)
  end

  def self.rides_by_driver(rides, driver_id)
    rides = rides.where(driver_id: driver_id) if driver_id.present?
    rides
  end

  def self.driver_today_view(date = nil)
    date = date.presence || Time.zone.today
    rides = rides_by_date(Ride.all, date)
    rides
  end

  # Filtering logic for rides table
  def self.filter_rides(filter_params)
    rides = Ride.all

    # Handle LIKE filters in a loop
    {
      day: "day",
      driver_name: "driver",
      passenger_name_and_phone: "passenger_name_and_phone",
      passenger_address: "passenger_address",
      destination: "destination",
      driver_email: "driver_email",
      driver_initials: "driver_initials",
      confirmed: "confirmed_with_passenger"
    }.each do |key, column|
      if filter_params[key].present?
        rides = rides.where(Ride.arel_table[column].lower.matches("%#{filter_params[key].downcase}%"))
      end
    end

    # Handle exact match filters
    {
      ride_count: "ride_count",
      amount_paid: "amount_paid",
      hours: "hours"
    }.each do |key, column|
      rides = rides.where(column => filter_params[key]) if filter_params[key].present?
    end

    # Handle date range filters
    if filter_params[:start_date].present?
      rides = rides.where("date >= ?", Date.parse(filter_params[:start_date]))
    end

    date_end = filter_params[:end_date].present? ? Date.parse(filter_params[:end_date]) : Date.today
    rides = rides.where("date <= ?", date_end) if date_end

    # Handle simple presence filter
    rides = rides.where(van: filter_params[:van]) if filter_params[:van].present?

    rides
  end
end
