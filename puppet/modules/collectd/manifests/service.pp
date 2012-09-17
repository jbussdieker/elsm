class collectd::service inherits collectd {

  monit::create_simple { 'collectd':
    pid_file => '/run/collectdmon.pid',
    cmd_name => 'collectd',
    group    => 'collectd',
  }

  service { 'collectd':
    ensure => 'running',
  }

}
