# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "ninja_share@163.com"
  layout "mailer"
end
