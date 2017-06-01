class UsersController < ApplicationController
  before_action :require_login, only: %w[index edit update destroy following followers]
  before_action :set_user,      only: %w[show edit update destroy following followers microposts microposts_feed]
  before_action :correct_user,  only: %w[edit update]
  before_action :admin_user,    only: %w[destroy]
  permits :name, :email, :password, :password_confirmation

  def index
    @users = User.page params[:page]
  end

  def show
    @microposts = @user.microposts.page params[:page]
  end

  def new
    @user = User.new
  end

  def create(user)
    @user = User.new(user)

    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render "new"
    end
  end

  def edit
  end

  def update(user)
    if @user.update_attributes(user)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @users = @user.following.page params[:page]
    render "show_follow"
  end

  def followers
    @title = "Followers"
    @users = @user.followers.page params[:page]
    render "show_follow"
  end

  def search
    @users = User.name_like(params[:name]).page params[:page]
  end

  def microposts
    @microposts = @user.microposts.content_like(params[:content]).page params[:page]
  end

  def microposts_feed
    @microposts = @user.microposts

    render rss: @microposts
  end

  def likes
    @user = current_user

    ids = []
    current_user.likes.each { |like| ids << like.micropost_id }
    @microposts = Micropost.where(id: ids).page params[:page]
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
