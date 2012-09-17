class logstash::service inherits logstash {

  monit::create_http { 'logstash': 
    pid_file => '/run/logstash.pid',
    cmd_name => 'logstash',
    group    => 'logstash',
    port     => '9200',
  }

  file { '/etc/init.d/logstash':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('logstash/logstash.erb'),
    notify  => Service['logstash'],
    require => Class['users::logstash'],
  }

  service { 'logstash':
    ensure  => 'running',
    require => File['/etc/init.d/logstash'],
  }

}
