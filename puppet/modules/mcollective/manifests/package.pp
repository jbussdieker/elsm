class mcollective::package inherits mcollective {

  package { 'mcollective':
    ensure => 'present',
  }

}
