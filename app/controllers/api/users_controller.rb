module Api
  class UsersController < Api::ApiController
    def me
      @user = current_user
      respond_with @user
    end
  end
end
