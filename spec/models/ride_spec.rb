# frozen_string_literal: true

require "rails_helper"

RSpec.describe Ride, type: :model do
  before(:each) do
    @driver1 = FactoryBot.create(:driver)
    @driver2 = FactoryBot.create(:driver)

    today = Time.zone.today
    today.strftime("%a")

    @ride1 = FactoryBot.create(:ride, driver: @driver1, date: Time.zone.today - 1.day, emailed_driver: true)
    @ride2 = FactoryBot.create(:ride, driver: @driver2)
    @ride3 = FactoryBot.create(:ride, driver: @driver1, date: Time.zone.today + 1.day)
  end

  describe "Validations" do
    it "is valid with all required attributes" do
      expect(@ride1).to be_valid
    end

    it "is certain fields valid" do
      expect(@ride1.emailed_driver?).to eq(true)
    end
  end

  after(:each) do
    Ride.delete_all
    Driver.delete_all
  end
end
