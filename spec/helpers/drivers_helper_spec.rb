# frozen_string_literal: true

require "rails_helper"

RSpec.describe DriversHelper, type: :helper do
  describe "#clickable_phone" do
    it "returns N/A when phone is blank" do
      expect(helper.clickable_phone(nil)).to eq("N/A")
      expect(helper.clickable_phone("")).to eq("N/A")
    end

    it "returns a tel link with a sanitized phone number" do
      html = helper.clickable_phone("(123) 456-7890")

      expect(html).to include('href="tel:1234567890"')
      expect(html).to include(">(123) 456-7890</a>")
    end
  end

  describe "#clickable_address" do
    it "returns N/A when address is blank" do
      expect(helper.clickable_address(nil)).to eq("N/A")
      expect(helper.clickable_address("")).to eq("N/A")
    end

    it "builds a Google Maps link using the address as label by default" do
      address = "2551 Hearst Ave, Berkeley"

      html = helper.clickable_address(address)

      expect(html).to include(
        "href=\"https://www.google.com/maps/search/?api=1&amp;query=2551%20Hearst%20Ave%2C%20Berkeley\""
      )
      expect(html).to include(">2551 Hearst Ave, Berkeley</a>")
      expect(html).to include('target="_blank"')
      expect(html).to include('rel="noopener noreferrer"')
    end

    it "uses the provided label when present" do
      html = helper.clickable_address("1 Main St", label: "Apple Maps")

      expect(html).to include(">Apple Maps</a>")
      expect(html).not_to include(">1 Main St</a>")
    end

    it "builds an Apple Maps link when provider is Apple" do
      html = helper.clickable_address("2551 Hearst Ave, Berkeley", provider: :apple)

      expect(html).to include("href=\"https://maps.apple.com/?q=2551%20Hearst%20Ave%2C%20Berkeley\"")
    end
  end

  describe "#clickable_address_with_options" do
    it "returns N/A when address is blank" do
      expect(helper.clickable_address_with_options(nil)).to eq("N/A")
      expect(helper.clickable_address_with_options("")).to eq("N/A")
    end

    it "renders both Google and Apple maps links" do
      html = helper.clickable_address_with_options("2551 Hearst Ave, Berkeley")

      expect(html).to include(
        "href=\"https://www.google.com/maps/search/?api=1&amp;query=2551%20Hearst%20Ave%2C%20Berkeley\""
      )
      expect(html).to include(">2551 Hearst Ave, Berkeley</a>")

      expect(html).to include("(<a")
      expect(html).to include("href=\"https://maps.apple.com/?q=2551%20Hearst%20Ave%2C%20Berkeley\"")
      expect(html).to include(">Apple Maps</a>")
    end
  end
end
