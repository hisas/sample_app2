class Settings::NotificationsController < ApplicationController
  def index
  end

  def create
    current_user.update(allow_followed_notification: true)
    redirect_to settings_notifications_url
  end

  def update
    current_user.update(allow_followed_notification: false)
    redirect_to settings_notifications_url
  end
end
