module Api
  class TwitterController < Api::ApiController
    def search(q)
      @users = current_user.twitter.user_search(q).map do |raw|
        TwitterUser.from_raw(raw)
      end
      respond_with @users
    end
  end
end
