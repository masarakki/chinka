@Nav = React.createClass
  contextTypes: { app: React.PropTypes.object.isRequired }
  handleClick: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @context.app.showTop()
  render: ->
    `<div className='navbar navbar-default navbar-static-top navbar-inverse'>
      <div className='container'>
        <button className='navbar-toggle' type='button' data-toggle='collapse' data-target='.navbar-responsive-collapse'>
          <span className='icon-bar' />
          <span className='icon-bar' />
          <span className='icon-bar' />
        </button>
        <a className='navbar-brand' href='/' onClick={this.handleClick} >
          <span className='chinka'>
            <span className='background'>Chinka</span>
            <span className='frontend'>Chinko</span>
          </span>
        </a>
        <div className='navbar-collapse collapse navbar-responsive-collapse'>
          <div className='pull-right'>
            <Login login={this.props.login} />
          </div>
        </div>
      </div>
    </div>`
