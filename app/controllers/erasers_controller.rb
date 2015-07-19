class ErasersController < ApplicationController
  before_action :authenticate_user!

  def index
    @erasers = current_user.erasers
    @eraser = Eraser.new

    respond_to do |format|
      format.html
      format.json { render json: @erasers }
    end
  end

  def create
    @erasers = current_user.erasers
    @eraser = current_user.erasers.new(eraser_params)

    if @eraser.save
      redirect_to :erasers
    else
      render action: :index, status: :unprocessable_entity
    end
  end

  def destroy
    @eraser = current_user.erasers.find(params[:id])
    @eraser.destroy
    redirect_to :erasers
  end

  private

  def eraser_params
    params.require(:eraser).permit(:twitter_name)
  end
end
