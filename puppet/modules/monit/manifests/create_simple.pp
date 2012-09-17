define monit::create_simple($pid_file, $cmd_name, $group) {

  file { "/etc/monit/conf.d/${title}":
    ensure  => 'present',
    content => template('monit/simple.erb'),
    require => Package['monit'],
    notify  => Class['monit::service'],
  }

}
