class StaticPagesController < ApplicationController
  skip_before_action :ensure_authenticated_user, only: :home

  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed(current_user).page(params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
