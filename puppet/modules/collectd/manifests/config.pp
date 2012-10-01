class collectd::config inherits collectd {

  file { '/opt/collectd':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/opt/collectd/carbon_writer.py':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/collectd/carbon_writer.py',
    require => File['/opt/collectd'],
    notify  => Service['collectd'],
  }

  file { '/etc/collectd/collectd.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('collectd/collectd.conf.erb'),
    notify  => Service['collectd'],
  }

}
