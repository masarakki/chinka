module Api
  class TweetsController < Api::ApiController
    before_action :set_user

    def index(page: 1)
      opts = {
        page: page,
        trim_user: true,
        exclude_replies: true,
        contributor_details: false,
        include_rts: false
      }
      @tweets = current_user.twitter.user_timeline(@user.uid.to_i, opts)
      respond_with @tweets
    end

    def destroy(id)
      current_user.destroy_tweet(@user, id.to_i)
      respond_with @user
    end

    protected

    def set_user
      @user = current_user.erasables.joins(:user).find_by!(users: { uid: params[:slave_id] }).user
    end
  end
end
