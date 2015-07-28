@BossList = React.createClass
  render: ->
    list = for boss in @props.bosses
      `<BossList.Row boss={boss} />`
    `<div>
      <h1>Your Bosses</h1>
      <BossList.Form />
      <div className='row'>{list}</div>
    </div>`

@BossList.Form = React.createClass
  contextTypes: { app: React.PropTypes.object.isRequired }
  handleSubmit: (e) ->
    e.preventDefault()
    e.stopPropagation()
    if @state.screen_name
      @context.app.addBoss(@state.screen_name).done =>
        @setState(screen_name: '')
  handleChange: (e) ->
    @setState(screen_name: e.target.value)
  getInitialState: ->
    { screen_name: '' }
  render: ->
    formStyle = { 'margin-bottom': '10px' }
    `<form className='form-inline' onSubmit={this.handleSubmit} style={formStyle} >
      <div className='form-group'>
        <div className='input-group'>
          <div className='input-group-addon'>@</div>
          <input type='text' className='form-control' value={this.state.screen_name} placeholder='screen_name' onChange={this.handleChange} />
        </div>
        &nbsp;
        <button type='submit' className='btn btn-primary'>
          <i className='fa fa-plus' />
          &nbsp;
          Boss
        </button>
      </div>
    </form>`

@BossList.Row = React.createClass
  contextTypes: { app: React.PropTypes.object.isRequired }
  handleClick: (e) ->
    @context.app.removeBoss(@props.boss)
  render: ->
    url = "https://twitter.com/#{@props.boss.screen_name}"
    `<div className='col-sm-6 col-md-4'>
      <div className='thumbnail'>
        <img src={this.props.boss.thumbnail} />
        <div className='caption text-center'>
          <h5 className='media-heading'>{this.props.boss.name}</h5>
          <p className='small'>
            <a href={url}>@{this.props.boss.screen_name}</a>
          </p>
          <p>
            <button className='btn btn-lg btn-danger' onClick={this.handleClick}>Remove</button>
          </p>
        </div>
      </div>
    </div>`

@BossBadge = React.createClass
  contextTypes: { app: React.PropTypes.object.isRequired }
  handleClick: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @context.app.showBossList()
  ignoreClick: (e) ->
    e.preventDefault()
    e.stopPropagation()
  render: ->
    if @props.bosses
      `<a className='list-group-item' href='/bosses' onClick={this.handleClick}>
        Boss
        <span className='badge'>{this.props.bosses.length}</span>
      </a>`
    else
      `<a className='list-group-item disabled' href='/bosses' onClick={this.ignoreClick}>Boss</a>`
