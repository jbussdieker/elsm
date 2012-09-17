class monit::setup inherits monit {

  include monit::package
  include monit::service
  include monit::config

}
