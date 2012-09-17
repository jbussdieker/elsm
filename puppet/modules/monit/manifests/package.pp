class monit::package inherits monit {

  package { 'monit':
    ensure => 'present',
  }

}
