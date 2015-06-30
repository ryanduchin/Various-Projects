class UsersController < ApplicationController
  before_action :redirect_if_signed_in, except: [:destroy]

  def new
    @user = User.new
    render :new
  end

  def create

    ##RENDER JSON
    @user = User.new(user_params)
    if @user.save
      flash[:messages] = ["Welcome to 99Cats"]
      login_user!
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user)
      .permit(:user_name, :password, :session_token)
  end
end
