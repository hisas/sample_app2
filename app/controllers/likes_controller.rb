class LikesController < ApplicationController
  before_action :set_micropost, only: %i(create destroy)

  def create
    Like.create(user_id: current_user.id, micropost_id: params[:micropost_id])

    @users = Micropost.find(params[:micropost_id]).liked_users

    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def destroy
    Like.find_by(user_id: current_user.id, micropost_id: params[:micropost_id]).destroy

    @users = Micropost.find(params[:micropost_id]).liked_users

    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  private
    def set_micropost
      @micropost = Micropost.find(params[:micropost_id])
    end
end
