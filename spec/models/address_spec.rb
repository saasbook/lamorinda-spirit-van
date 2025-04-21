# frozen_string_literal: true

require "rails_helper"

RSpec.describe Address, type: :model do
  before(:each) do
    @address1 = FactoryBot.create(:address)
    @address2 = FactoryBot.create(:address)
  end

  describe "Full address" do
    it "is full address" do
      expect(@address1.full_address).to include(@address1.city)
    end
  end
end
