class rabbitmq::setup inherits rabbitmq {

  include monit::setup
  include users::rabbitmq

  include rabbitmq::package
  include rabbitmq::config
  include rabbitmq::service

}
