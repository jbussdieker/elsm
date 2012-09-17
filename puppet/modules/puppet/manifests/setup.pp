class puppet::setup inherits puppet {

  include monit::setup

  include puppet::config
  include puppet::service

}
