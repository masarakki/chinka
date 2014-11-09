class CallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.from_twitter(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
    else
      session['devise.twitter_data'] = request.env['omniauth.auth']
      redirect_to :root
    end
  end
end
