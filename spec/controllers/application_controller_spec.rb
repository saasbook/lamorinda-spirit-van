# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: "OK"
    end
  end

  describe "#after_sign_in_path_for" do
    before do
      @admin      = FactoryBot.build_stubbed(:user, role: "admin")
      @dispatcher = FactoryBot.build_stubbed(:user, role: "dispatcher")
      @driver     = FactoryBot.build_stubbed(:user, role: "driver")
      @no_role    = FactoryBot.build_stubbed(:user, role: nil)
    end

    it "redirects admin to admin_users_path" do
      result = controller.send(:after_sign_in_path_for, @admin)
      expect(result).to eq(admin_users_path)
    end

    it "redirects dispatcher to rides_path" do
      result = controller.send(:after_sign_in_path_for, @dispatcher)
      expect(result).to eq(rides_path)
    end

    it "redirects driver to drivers_path" do
      result = controller.send(:after_sign_in_path_for, @driver)
      expect(result).to eq(drivers_path)
    end

    it "redirects users with no role to root_path" do
      result = controller.send(:after_sign_in_path_for, @no_role)
      expect(result).to eq(root_path)
    end
  end
end
