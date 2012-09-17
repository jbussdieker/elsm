class elsm_web::config inherits elsm_web {

  file { '/etc/elsm.yml':
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
    source => 'puppet:///elsm_web/elsm.yml',
  }

  file { '/etc/init.d/elsm_web':
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///elsm_web/elsm_web',
  }

}
