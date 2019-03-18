class ApplicationMailer < ActionMailer::Base
  email_with_name = %("CommonfloorClone" <noreply@commonfloorclone.herokuapp.com>)
  default from: email_with_name
  layout 'mailer'
end