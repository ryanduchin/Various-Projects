class GoalsController < ApplicationController
  before_action :ensure_logged_in, only: [:index]

  def index
    @goals = Goal.all
  end

  def show
    @goal = Goal.find(params[:id])
    if @goal
      if @goal.private == 0 || @goal.user_id == current_user.id
        render :show
      else
        flash[:errors] = "This goal is set to private"
        render :index
      end
    else
      flash[:errors] = @goal.errors.full_messages
      render :index
    end
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_url
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :body, :private, :completed)
  end

end
