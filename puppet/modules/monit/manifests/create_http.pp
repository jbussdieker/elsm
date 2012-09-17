define monit::create_http($pid_file, $cmd_name, $group, $port) {

  file { "/etc/monit/conf.d/${title}":
    ensure  => 'present',
    content => template('monit/http.erb'),
    require => Package['monit'],
    notify  => Class['monit::service'],
  }

}
