class puppet_master::setup inherits puppet_master {

  include monit::setup

  include puppet_dashboard::setup

  include puppet_master::config
  include puppet_master::service

}
