# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationCable::Channel, type: :channel do
  class DummyChannel < ApplicationCable::Channel
    def subscribed
      stream_from "dummy_channel"
    end
  end

  it "successfully subscribes" do
    stub_connection
    subscribe channel_class: DummyChannel
    expect(subscription).to be_confirmed
  end
end
