class SessionsController < ApplicationController
  before_action :redirect_if_signed_in, except: [:destroy]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params[:user_name], user_params[:password])
    if @user && @user.is_password?(user_params[:password])
      login_user!
    else
      @user = User.new(user_params)
      flash.now[:errors] = ["Username and password mismatch."]
      render :new
    end
  end

  def destroy
    @user = current_user
    session[:session_token] = nil
    @user.reset_session_token!
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user)
      .permit(:user_name, :password, :session_token)
  end
end
