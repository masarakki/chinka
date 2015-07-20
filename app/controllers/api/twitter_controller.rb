module Api
  class TwitterController < Api::ApiController
    def search
      @users = current_user.twitter.user_search(params[:q]).map do |raw|
        TwitterUser.from_raw(raw)
      end
      respond_with @users
    end
  end
end
