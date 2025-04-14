# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@lovelafayette.org"
  layout "mailer"
end
