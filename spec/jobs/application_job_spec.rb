# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationJob, type: :job do
  class DummyJob < ApplicationJob
    def perform
      # simulate a simple task
      Rails.logger.info "DummyJob performed"
    end
  end

  it "can perform a job successfully" do
    expect {
      DummyJob.perform_now
    }.not_to raise_error
  end
end
