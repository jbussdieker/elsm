class puppet_dashboard::service inherits puppet_dashboard {

  monit::create_simple { 'puppet-dashboard-workers':
    pid_file => '/opt/puppet-dashboard/tmp/pids/delayed_job.pid',
    cmd_name => 'puppet-dashboard-workers',
    group    => 'puppet-dashboard',
  }

  monit::create_http { 'puppet-dashboard-web':
    pid_file => '/opt/puppet-dashboard/tmp/pids/server.pid',
    cmd_name => 'puppet-dashboard',
    group    => 'puppet-dashboard',
    port     => 3000,
  }

  file { '/etc/init.d/puppet-dashboard':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/puppet_dashboard/initscript',
    notify  => Service['puppet-dashboard'],
  }

  file { '/etc/init.d/puppet-dashboard-workers':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/puppet_dashboard/workerscript',
    notify  => Service['puppet-dashboard-workers'],
  }

  service { 'puppet-dashboard':
    ensure  => 'running',
    require => File['/etc/init.d/puppet-dashboard'],
  }

  service { 'puppet-dashboard-workers':
    ensure  => 'running',
    require => File['/etc/init.d/puppet-dashboard-workers'],
  }

}
