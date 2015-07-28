@Root = React.createClass
  childContextTypes: { app: React.PropTypes.object.isRequired }
  getChildContext: ->
    { app: this }
  componentWillMount: ->
    $.ajax(Routes.api_user_path()).done((res) =>
      @setState(login: res)
      @fetchBosses()
      @fetchSlaves()
    ).fail (res) =>
      @setState(login: false)
  fetchBosses: ->
    $.ajax(Routes.api_bosses_path()).done (res) =>
      @setState(bosses: res)
  fetchSlaves: ->
    $.ajax(Routes.api_slaves_path()).done (res) =>
      @setState(slaves: res)
  getInitialState: ->
    { login: null, bosses: null, slaves: null, view: 'Top' }
  showTop: ->
    @setState(view: 'Top')
  showBossList: ->
    @setState(view: 'BossList')
  showBoss: (boss) ->
    @setState(view: 'Boss', boss: boss)
  addBoss: (screen_name) ->
    $.post(Routes.api_bosses_path(), screen_name: screen_name).done (res) =>
      bosses = @state.bosses
      bosses.push(res)
      @setState(bosses: bosses)
  removeBoss: (boss) ->
    $.ajax(Routes.api_boss_path(boss.id), method: 'delete').done (res) =>
        bosses = @state.bosses.filter (x) ->
          x.id != boss.id
        @setState(bosses: bosses)
  showSlaveList: ->
    @setState(view: 'SlaveList')
  showSlave: (slave) ->
    @setState(view: 'Slave', slave: slave)
  removeSlave: (slave) ->
    $.ajax(Routes.api_slave_path(slave.id), method: 'delete').done (res) =>
        slaves = @state.slaves.filter (x) ->
          x.id != slave.id
        @setState(slaves: slaves)
  render: ->
    if @state.login == null
      `<div>Loading...</div>`
    else if @state.login == false
      `<div>
        <Nav login={this.state.login} />
        <Top />
      </div>`
    else
      Child = window[@state.view]
      inner = switch @state.view
        when 'Top'
          `<Top />`
        when 'BossList'
          `<BossList root={this} bosses={this.state.bosses} />`
        when 'SlaveList'
          `<SlaveList root={this} slaves={this.state.slaves} />`
      `<div>
        <Nav login={this.state.login} root={this} />
        <div className='container'>
          <div className='row'>
            <div className='col-md-2 col-lg-2'>
              <div className='well sidebar-nav'>
                <Panel login={this.state.login} />
              </div>
              <div className='list-group'>
                <BossBadge root={this} bosses={this.state.bosses} />
                <SlaveBadge root={this} slaves={this.state.slaves} />
              </div>
            </div>
            <div className='col-md-9 col-ld-9'>
              <Child {...this.props} {...this.state} />
            </div>
          </div>
        </div>
      </div>`
