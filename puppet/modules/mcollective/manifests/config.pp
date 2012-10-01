class mcollective::config inherits mcollective {

  file { '/usr/share/mcollective/plugins/mcollective/agent':
    ensure => directory,
    recurse => true,
    purge   => true,
    source => 'puppet:///modules/mcollective/agents',
    notify  => Class['mcollective::service'],
    require => Package['mcollective'],
  }

  file { '/etc/mcollective/client.cfg':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0600',
    content => template('mcollective/client.cfg.erb'),
    notify  => Class['mcollective::service'],
    require => Package['mcollective'],
  }

  file { '/etc/mcollective/server.cfg':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0600',
    content => template('mcollective/server.cfg.erb'),
    notify  => Class['mcollective::service'],
    require => Package['mcollective'],
  }

}
