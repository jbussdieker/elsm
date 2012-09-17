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

}
