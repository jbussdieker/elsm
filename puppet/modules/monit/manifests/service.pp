class monit::service inherits monit {

  service { 'monit':
    ensure => 'running',
  }

}
