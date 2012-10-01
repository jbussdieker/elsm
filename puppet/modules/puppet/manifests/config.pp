class puppet::config inherits puppet {

  file { '/etc/puppet/puppet.conf':
    ensure => 'present',
    content => template('puppet/puppet.conf.erb'),
  }

  file { '/etc/default/puppet':
    ensure => 'present',
    source => 'puppet:///modules/puppet/puppet.default',
  }

}
