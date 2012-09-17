class master::setup inherits master {
  $stomp_server = $master
  $stomp_user = "mcollective"
  $stomp_password = "marionette"

  include puppet_master::setup

  include graphite::setup
  include collectd::setup

  include rabbitmq::setup
  include mcollective::setup

  include rvm::setup
  include elsm_web::setup

  rabbitmq::add_user { $stomp_user:
    u_password => $stomp_password,
    notify     => Class['mcollective::service'],
  }

}
