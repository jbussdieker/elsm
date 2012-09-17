class elsm_web::service inherits elsm_web {

  service { 'elsm_web':
    ensure  => running,
    require => Class['elsm_web::config'],
  }

}
