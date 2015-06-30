class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to goals_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    if @user
      render :show
    else
      flash[:errors] = ["no user dude"]
      redirect_to :back
    end
  end


  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
