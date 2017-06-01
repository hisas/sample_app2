class MicropostsController < ApplicationController
  before_action :require_login, only: %w[create destroy]
  before_action :correct_user,  only: %w[destroy]
  permits :content, :picture

  def create(micropost)
    @micropost = current_user.microposts.build(micropost)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  def search
    @micropost  = current_user.microposts.build
    @feed_items = Micropost.content_like(params[:content]).page params[:page]
  end

  def likes
    @micropost  = current_user.microposts.build

    ids = []
    current_user.likes.each { |like| ids << like.micropost_id }
    @feed_items = Micropost.where(id: ids).page params[:page]
  end

  private
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
