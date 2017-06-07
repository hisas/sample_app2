class Api::V1::UsersController < ApplicationController
  http_basic_authenticate_with name: ENV["BASIC_AUTH_NAME"], password: ENV["BASIC_AUTH_PASSWORD"]

  before_action :set_user, only: %i(show edit update destroy)

  def index
    @users = User.all
  end

  def show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      render :show
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head(:no_content)
  end

  private
    def user_params
      params.permit(:name, :nickname, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
