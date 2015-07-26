module Api
  class UsersController < Api::ApiController
    def show
      @user = current_user.me
      respond_with @user
    end
  end
end
