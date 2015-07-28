@Slave = React.createClass
  childContextTypes: { slave: React.PropTypes.object.isRequired }
  getChildContext: ->
    { slave: this }
  propTypes: { slave: React.PropTypes.object.isRequired }
  fetchTweets: (page) ->
    $.ajax(Routes.api_slave_tweets_path(@props.slave.id, page: page)).done (res) =>
      @setState(tweets: res, page: page)
  removeTweet: (id) ->
    $.ajax(Routes.api_slave_tweet_path(@props.slave.id, id), method: 'DELETE').done (res) =>
      tweets = @state.tweets.filter (x) ->
          x.id_str != id
      @setState(tweets: tweets)
  getInitialState: ->
    page = @props.page || 1
    @fetchTweets(page)
    { tweets: []}
  render: ->
    tweets = for tweet in @state.tweets
      `<Slave.Tweet key={tweet.id_str} user={this.props.slave} tweet={tweet} />`
    `<div>{tweets}</div>`
@Slave.Tweet = React.createClass
  contextTypes: { slave: React.PropTypes.object.isRequired }
  handleRemove: (e) ->
    e.stopPropagation()
    e.preventDefault()
    @context.slave.removeTweet(@props.tweet.id_str) if confirm('Are Your Sure?')
  render: ->
    date = new Date(@props.tweet.created_at).toString()
    `<div className='well deletable'>
      <a href='#' onClick={this.handleRemove} className='close'>
        &times;
      </a>
      <p>
        @{this.props.user.screen_name}
        &nbsp;
        {date}
      </p>
      <p>{this.props.tweet.text}</p>
    </div>`

@SlaveList = React.createClass
  render: ->
    list = for slave in @props.slaves
      `<SlaveList.Row slave={slave} />`
    `<div>
      <h1>Your Slaves</h1>
      <div className='row'>{list}</div>
    </div>`

@SlaveList.Row = React.createClass
  contextTypes: { app: React.PropTypes.object.isRequired }
  handleShow: (e) ->
    @context.app.showSlave(@props.slave)
  handleRemove: (e) ->
    @context.app.removeSlave(@props.slave) if confirm('Are you sure?')
  render: ->
    url = "https://twitter.com/#{@props.slave.screen_name}"
    `<div className='col-sm-6 col-md-4'>
      <div className='thumbnail'>
        <img src={this.props.slave.thumbnail} />
        <div className='caption text-center'>
          <h5 className='media-heading'>{this.props.slave.name}</h5>
          <p className='small'>
            <a href={url}>@{this.props.slave.screen_name}</a>
          </p>
          <p>
            <button className='btn btn-lg btn-success' onClick={this.handleShow}>Tweets</button>
            &nbsp;
            <button className='btn btn-lg btn-danger' onClick={this.handleRemove}>Remove</button>
          </p>
        </div>
      </div>
    </div>`

@SlaveBadge = React.createClass
  contextTypes: { app: React.PropTypes.object.isRequired }
  handleClick: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @context.app.showSlaveList()
  ignoreClick: (e) ->
    e.preventDefault()
    e.stopPropagation()
  render: ->
    if @props.slaves
      `<a className='list-group-item' href='/slaves' onClick={this.handleClick}>
        Slave
        <span className='badge'>{this.props.slaves.length}</span>
      </a>`
    else
      `<a className='list-group-item disabled' href='/slaves' onClick={this.ignoreClick}>Slave</a>`
