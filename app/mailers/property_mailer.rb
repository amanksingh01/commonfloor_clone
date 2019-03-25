class PropertyMailer < ApplicationMailer
  helper :application
  helper :properties

  def interested_user(property, user)
    @property = property
    @seller   = property.user
    @user     = user
    email_with_name = %("#{@seller.name}" <#{@seller.email}>)
    mail to:      email_with_name,
         subject: "#{user.name} is interested in your property"
  end
end