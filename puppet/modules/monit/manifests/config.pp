class monit::config inherits monit {

  file { '/etc/monit/monitrc':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    source  => 'puppet:///monit/monitrc',
    require => Package['monit'],
    notify  => Class['monit::service'],
  }

}
