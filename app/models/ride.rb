# frozen_string_literal: true

class Ride < ApplicationRecord
  validates :day, :date, :passenger_name_and_phone, presence: true

  def self.today_rides(rides, date)
    rides.where(date: date)
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
  #
  # the date parameter is optional, if not present, return rides for Time.zone.today
  # if date is present, return rides for that "date"(could be yesterday, tomorrow, etc, depends on how user selects)
  # if date is not present, return rides for today

  def self.driver_today_view(driver_name_text = nil, driver_name_select = nil, date = nil)
    date = date.presence || Time.zone.today
    # date = date.presence
    rides = today_rides(Ride.all, date)
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
