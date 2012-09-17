class sudoers::config inherits sudoers {

  file { '/etc/sudoers':
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0440',
    source => 'puppet:///sudoers/default.sudoers',
  }

}
