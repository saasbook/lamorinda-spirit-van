# frozen_string_literal: true

require "rails_helper"

RSpec.describe Ride, type: :model do
  before(:each) do
    @driver1 = FactoryBot.create(:driver)
    @driver2 = FactoryBot.create(:driver)

    today = Time.zone.today
    today.strftime("%a")

    @ride1 = FactoryBot.create(:ride, driver: @driver1, date: Time.zone.today - 1.day)
    @ride2 = FactoryBot.create(:ride, driver: @driver2)
    @ride3 = FactoryBot.create(:ride, driver: @driver1, date: Time.zone.today + 1.day)
  end

  describe "Validations" do
    it "is valid with all required attributes" do
      expect(@ride1).to be_valid
    end

    #   it "is invalid without a day" do
    #     ride = Ride.new(date: Time.zone.today, passenger_name_and_phone: "John Doe (555-123-4567)")
    #     expect(ride).not_to be_valid
    #     expect(ride.errors[:day]).to include("can't be blank")
    #   end

    #   it "is invalid without a date" do
    #     ride = Ride.new(day: "F", passenger_name_and_phone: "John Doe (555-123-4567)")
    #     expect(ride).not_to be_valid
    #     expect(ride.errors[:date]).to include("can't be blank")
    #   end

    #   it "is invalid without passenger_name_and_phone" do
    #     ride = Ride.new(day: "F", date: Time.zone.today)
    #     expect(ride).not_to be_valid
    #     expect(ride.errors[:passenger_name_and_phone]).to include("can't be blank")
    #   end
  end

  describe ".rides_by_date" do
    it "returns rides that are scheduled for today" do
      rides = Ride.rides_by_date(Ride.all, Time.zone.today)
      expect(rides).to match_array([ @ride2 ])
    end

    it "returns rides that are scheduled for yesterday" do
      rides = Ride.rides_by_date(Ride.all, Time.zone.today - 1.day)
      expect(rides).to match_array([ @ride1 ])
    end

    it "returns rides that are scheduled for tomorrow" do
      rides = Ride.rides_by_date(Ride.all, Time.zone.today + 1.day)
      expect(rides).to match_array([ @ride3 ])
    end
  end

  describe ".rides_by_driver" do
    it "returns rides for a given driver" do
      rides = Ride.rides_by_driver(Ride.all, @driver1.id)
      expect(rides).to match_array([ @ride1, @ride3 ])
    end

    it "returns all rides when driver_name is nil" do
      rides = Ride.rides_by_driver(Ride.all, nil)
      expect(rides).to match_array([ @ride1, @ride2, @ride3 ])
    end
  end

  describe ".driver_today_view" do
    it "returns all rides when no filters are applied" do
      rides = Ride.driver_today_view(nil)
      expect(rides).to match_array([ @ride2 ])
    end
  end

  after(:each) do
    Ride.delete_all
    Driver.delete_all
  end
end
