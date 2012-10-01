class puppet_master::config inherits puppet_master {

  file { '/etc/puppet/puppet.conf':
    ensure => 'present',
    content => template('puppet_master/puppet.conf.erb'),
  }

  file { '/etc/default/puppet':
    ensure => 'present',
    source => 'puppet:///modules/puppet/puppet.default',
  }

  file { '/etc/default/puppetmaster':
    ensure => 'present',
    source => 'puppet:///modules/puppet_master/puppetmaster.default',
  }

}
