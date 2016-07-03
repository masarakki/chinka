@Login = React.createClass
  render: ->
    if @props.login
      `<p className='navbar-text'>
        {this.props.login.name}
      </p>`
    else
      url = Routes.user_twitter_omniauth_authorize_path('twitter', format: null)
      `<a href={url} className='btn navbar-btn btn-default'>
        Authorize with Twitter
      </a>`
