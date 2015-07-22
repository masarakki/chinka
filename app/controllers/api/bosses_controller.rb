module Api
  class BossesController < Api::ApiController
    def index
      @bosses = current_user.bosses
      respond_with @bosses
    end

    def create(screen_name)
      user = TwitterUser.from_raw(current_user.twitter.user(screen_name))
      @eraser = current_user.erasers.create(twitter_user: user)
      respond_with @eraser, location: api_boss_path(user.id)
    end

    def destroy(id)
      @eraser = current_user.erasers.find_by!(twitter_id: id.to_i)
      @eraser.destroy
      respond_with @eraser
    end
  end
end
