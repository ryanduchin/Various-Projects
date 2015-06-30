class SessionsController < ApplicationController
  before_action :require_not_logged_in!, only: [:new, :create]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params)
    if !!@user
      login_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
