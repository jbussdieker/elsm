class users::rabbitmq inherits users {

  users::add_user { 'rabbitmq' :
    u_uid   => 1216,
    u_shell => '/bin/false',
    u_home  => '/var/lib/rabbitmq',
  }

}
