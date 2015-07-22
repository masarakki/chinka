module Api
  class UsersController < Api::ApiController
    def me
      @user = current_user.me
      respond_with @user
    end
  end
end
