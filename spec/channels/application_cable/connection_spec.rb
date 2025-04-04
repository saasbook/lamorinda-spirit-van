# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationCable::Connection, type: :channel do
  it "successfully connects" do
    connect "/cable"
    expect(connection).to be_an_instance_of(ApplicationCable::Connection)
  end
end
