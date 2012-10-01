class mcontrol::service inherits mcontrol {

  monit::create_http { 'mcontrol':
    pid_file => '/run/mcontrol.pid',
    cmd_name => 'mcontrol',
    group    => 'mcontrol',
    port     => 8089,
    require  => Service['mcontrol'],
  }

  file { '/etc/init.d/mcontrol':
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/mcontrol/mcontrol',
    notify => Service['mcontrol'],
  }

  service { 'mcontrol':
    ensure  => running,
    require => File['/etc/init.d/mcontrol'],
  }

}
