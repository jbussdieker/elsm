class puppet::service inherits puppet {

  monit::create_simple { 'puppet-agent': 
    pid_file => '/run/puppet/agent.pid',
    cmd_name => 'puppet',
    group    => 'puppet',
  }

}
