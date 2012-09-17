class elsm_web::service inherits elsm_web {

  monit::create_http { 'elsm-web': 
    pid_file => '/run/elsm_web.pid',
    cmd_name => 'elsm_web',
    group    => 'elsm_web',
    port     => '8088',
  }

  service { 'elsm_web':
    ensure  => running,
    require => Class['elsm_web::config'],
  }

}
