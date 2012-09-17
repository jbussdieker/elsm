class puppet_master::service inherits puppet_master {

  monit::create_simple { 'puppet-master': 
    pid_file => '/run/puppet/master.pid',
    cmd_name => 'puppetmaster',
    group    => 'puppet',
  }

  monit::create_simple { 'puppet-agent': 
    pid_file => '/run/puppet/agent.pid',
    cmd_name => 'puppet',
    group    => 'puppet',
  }

}
