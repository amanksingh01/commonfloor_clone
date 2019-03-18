class PropertyMailer < ApplicationMailer

  def interested_user(property, user)
    @property = property
    @seller   = property.user
    @user     = user
    mail to: @seller.email, subject: "#{user.name} is interested in your property"
  end
end