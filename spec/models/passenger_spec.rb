# frozen_string_literal: true

require "rails_helper"

RSpec.describe Passenger, type: :model do
  before(:each) do
    @passenger1 = FactoryBot.create(:passenger, hispanic: true)
    @passenger2 = FactoryBot.create(:passenger)
  end

  describe "Hispanic" do
    it "is Hispanic" do
      expect(@passenger1.hispanic?).to eq(true)
    end
  end
end
