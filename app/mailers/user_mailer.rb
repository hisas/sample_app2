class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end

  def followed_notification(follow_user, followed_user)
    @follow_user = follow_user
    @followed_user = followed_user
    mail to: followed_user.email, subject: "You have a new follower"
  end
end
