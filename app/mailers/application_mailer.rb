# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "Ninja_share@163.com"
  layout "mailer"
end
