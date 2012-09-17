define monit::create_service {

  file { "/etc/monit/conf.d/${title}":
    ensure  => 'present',
    source  => "puppet:///monit/${title}",
    require => Package['monit'],
    notify  => Class['monit::service'],
  }

}
