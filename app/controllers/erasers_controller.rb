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
    begin
      @eraser.twitter_id = current_user.twitter.user(@eraser.twitter_name).id
    rescue Twitter::Error::NotFound
      @eraser.twitter_id = nil
    end

    if @eraser.save
      respond_to do |format|
        format.html { redirect_to :erasers }
        format.json { render json: @eraser, status: :created }
      end
    else
      respond_to do |format|
        format.html { render action: :index, status: :unprocessable_entity }
        format.json { render json: @eraser.errors, status: :unprocessable_entity }
      end
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
