class ApplicationMailer < ActionMailer::Base
  default from: ENV["EMAIL_USER"]
  layout Settings.mailer.mailer
end
