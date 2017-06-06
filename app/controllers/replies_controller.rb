class RepliesController < ApplicationController
  def new
    @micropost = Micropost.find(params[:micropost_id])

    @before_reply = Micropost.find(@micropost.reply_micropost) if @micropost.reply_micropost.present?
    @after_replies = Micropost.where(reply_micropost: @micropost.id)

    @reply = current_user.microposts.build(reply_nickname: @micropost.user.nickname, reply_micropost: @micropost.id)
  end

  def create
    @micropost = current_user.microposts.build(reply_nickname: params[:micropost][:reply_nickname], reply_micropost: params[:micropost][:reply_micropost], content: params[:micropost][:content])

    if @micropost.save
      flash[:success] = "Reply created!"
    else
      flash[:danger] = "Reply failed!"
    end
    redirect_to root_url
  end
end
