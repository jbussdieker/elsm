class graphite::service inherits graphite {

  file { '/etc/init.d/carbon-cache':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///graphite/carbon-cache',
    require => Class['graphite::package'],
    notify  => Service['carbon-cache'],
  }

  service { 'carbon-cache':
    ensure  => 'running',
    require => File['/etc/init.d/carbon-cache'],
  }

  monit::create_simple { 'carbon-cache': 
    pid_file => '/opt/graphite/storage/carbon-cache-a.pid',
    cmd_name => 'carbon-cache',
    group    => 'graphite',
    require  => File['/etc/init.d/carbon-cache'],
  }

  file { '/etc/init.d/graphite-web':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///graphite/graphite-web',
    require => Class['graphite::package'],
    notify  => Service['graphite-web'],
  }

  service { 'graphite-web':
    ensure  => 'running',
    require => File['/etc/init.d/graphite-web'],
  }

  monit::create_http { 'graphite-web': 
    pid_file => '/opt/graphite/graphite-web.pid',
    cmd_name => 'graphite-web',
    group    => 'graphite',
    port     => '8080',
    require  => File['/etc/init.d/graphite-web'],
  }

}
