class CatRentalRequestsController < ApplicationController


  # def new
  #   @cat_rental_request = CatRentalRequest.new(cat_id: params(:cat_id))
  #   render :new
  # end

  def show
    @request = CatRentalRequest.find(params[:id])
    @cat = @request.cat
    render :show
  end

  def new
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(request_params)
    if @cat_rental_request.save
      redirect_to cat_rental_request_url(@cat_rental_request)
    else
      flash.now[:errors] = @cat_rental_request.errors.full_messages
      render :new
    end
  end

  def edit
    @cat_rental_request = CatRentalRequest.find(params[:id])
    render :edit
  end

  def update
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.status = "PENDING"
    if @cat_rental_request.update(request_params)
      redirect_to cat_rental_request_url(@cat_rental_request)
    else
      flash.now[:errors] = @cat_rental_request.errors.full_messages
      render :edit
    end
  end

  def approve
    @request = CatRentalRequest.find(params[:cat_rental_request_id])
    @request.approve!
    redirect_to :back
  end

  def deny
    @request = CatRentalRequest.find(params[:cat_rental_request_id])
    @request.deny!
    redirect_to :back
  end

  private

  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end

end
