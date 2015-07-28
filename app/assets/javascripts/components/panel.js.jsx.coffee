@Panel = React.createClass
  render: ->
    url = "https://twitter.com/#{@props.login.screen_name}"
    `<div className='row'>
      <div className='col-md-12 col-lg-12'>
        <img src={this.props.login.image} className='img-thumbnail' />
      </div>
      <div className='text-center'>
        <strong>{this.props.login.name}</strong>
        <br />
        <a href={url}>@{this.props.login.screen_name}</a>
      </div>
    </div>`
