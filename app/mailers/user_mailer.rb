class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    email_with_name = %("#{user.name}" <#{user.email}>)
    mail to: email_with_name, subject: "Account activation"
  end

  def password_reset(user)
    @user = user
    email_with_name = %("#{user.name}" <#{user.email}>)
    mail to: email_with_name, subject: "Password reset"
  end
end
