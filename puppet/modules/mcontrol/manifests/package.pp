class mcontrol::package inherits mcontrol {

  package { 'bundler':
    provider => 'gem',
    ensure => '1.2.0',
    require => Package['rubygems'],
  }

  vcsrepo { '/srv/mcontrol':
    ensure   => 'latest',
    revision => 'master',
    provider => git,
    source   => "git://github.com/jbussdieker/mcontrol.git",
    require  => Package['git'],
    notify   => Service['mcontrol'],
  }

}
