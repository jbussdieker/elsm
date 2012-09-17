class elsm_web::package inherits elsm_web {

  package { 'libxslt1-dev':
    ensure => 'installed',
  }

  package { 'libxml2-dev':
    ensure => 'installed',
  }

  package { 'nodejs':
    ensure => 'installed',
  }

  vcsrepo { '/srv/elsm_web':
    ensure   => 'latest',
    revision => 'master',
    provider => git,
    source   => "git://github.com/jbussdieker/elsm_web.git",
    require  => Package['git'],
    notify   => Service['elsm_web'],
  }

}
