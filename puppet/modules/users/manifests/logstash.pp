class users::logstash inherits users {

  users::add_user { 'logstash' :
    u_uid   => 1217,
    u_shell => '/bin/false',
  }

}
