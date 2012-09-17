class puppet_dashboard::setup inherits puppet_dashboard {

  include monit::setup
  include mysql_server::setup

  include puppet_dashboard::config
  include puppet_dashboard::package
  include puppet_dashboard::service

}
