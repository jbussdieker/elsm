class rabbitmq::package inherits rabbitmq {

  package { 'rabbitmq-server':
    ensure => 'present',
  }

  package { 'rabbitmq-stomp':
    ensure => 'present',
  }

}
