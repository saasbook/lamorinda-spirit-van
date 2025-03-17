# frozen_string_literal: true

require "rails_helper"

RSpec.describe Shift, type: :model do
  before(:each) do
    @driver = FactoryBot.create(:driver)
  end

  context "validations" do
    it "is valid with valid attributes" do
      shift = Shift.new(shift_date: Date.today, shift_type: "am", driver: @driver)
      expect(shift).to be_valid
    end

    it "is invalid without a shift_date" do
      shift = Shift.new(shift_date: nil, shift_type: "am", driver: @driver)
      expect(shift).not_to be_valid
      expect(shift.errors[:shift_date]).to include("can't be blank")
    end

    it "is invalid without a shift_type" do
      shift = Shift.new(shift_date: Date.today, shift_type: nil, driver: @driver)
      expect(shift).not_to be_valid
      expect(shift.errors[:shift_type]).to include("can't be blank")
    end

    it "is invalid without a driver" do
      shift = Shift.new(shift_date: Date.today, shift_type: "am", driver: nil)
      expect(shift).not_to be_valid
      expect(shift.errors[:driver]).to include("must exist")
    end
  end
end
