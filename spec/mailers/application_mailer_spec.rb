# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationMailer, type: :mailer do
  class DummyMailer < ApplicationMailer
    def test_email
      mail(to: "test@example.com", subject: "Hello", body: "This is a test email.")
    end
  end

  it "sends a test email" do
    email = DummyMailer.test_email
    expect(email.to).to eq(["test@example.com"])
    expect(email.subject).to eq("Hello")
    expect(email.body.encoded).to include("This is a test email.")
  end
end
