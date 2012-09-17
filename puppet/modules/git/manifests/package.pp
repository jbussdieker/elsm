class git::package inherits git {

  package { 'git':
    ensure => 'present',
  }

}
