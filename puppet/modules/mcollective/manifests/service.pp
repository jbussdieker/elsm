class mcollective::service inherits mcollective {

  #monit::create_simple { 'mcollective': 
  #  pid_file => '/run/mcollectived.pid',
  #  cmd_name => 'mcollective',
  #  group    => 'mcollective',
  #}

  service { 'mcollective':
    ensure => running,
  }

}
