class UsersController < ApplicationController
  before_action :require_not_logged_in!, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params) #new user, don't find_by!!
    if @user.save
      login_user!(@user)
      redirect_to user_url(@user)
      # redirect_to us
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

end
