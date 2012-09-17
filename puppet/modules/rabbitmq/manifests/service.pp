class rabbitmq::service inherits rabbitmq {

  monit::create_simple { 'rabbitmq': 
    pid_file => '/run/rabbitmq/pid',
    cmd_name => 'rabbitmq-server',
    group    => 'rabbitmq',
  }

}
