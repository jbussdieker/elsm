class collectd::package inherits collectd {

  package { 'collectd':
    ensure => 'present',
  }

}
