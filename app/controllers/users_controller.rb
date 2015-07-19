class UsersController < ApplicationController
  def show
    @user = current_user.slaves.find_by_nick(params[:id])
    return head :not_found unless @user
    @tweets = current_user.twitter.user_timeline(@user.uid.to_i, page: (params[:page] || 1).to_i)
  end

  def tweets
    id = params[:id].to_i
    @user = current_user.slaves.find_by_nick(params[:user_id])
    return head :not_found unless @user
    current_user.destroy_tweet(@user, id)
    head :ok
  end
end
