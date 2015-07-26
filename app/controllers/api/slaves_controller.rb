module Api
  class SlavesController < Api::ApiController
    def index
      @slaves = current_user.members
      respond_with @slaves
    end

    def destroy(id)
      @eraser = current_user.erasables.joins(:user).find_by!(users: { uid: id })
      @eraser.destroy
      respond_with @eraser
    end
  end
end
