class SettingsController < ApplicationController
  def index
  end

  def allow_followed_notification
    current_user.update(allow_followed_notification: true)
    redirect_to settings_url
  end

  def disallow_followed_notification
    current_user.update(allow_followed_notification: false)
    redirect_to settings_url
  end
end
