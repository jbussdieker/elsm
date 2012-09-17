class puppet_dashboard::package inherits puppet_dashboard {
  $file = "puppet-dashboard-1.2.10"

  package { 'rubygems':
    ensure => 'present',
  }

  package { 'rake':
    provider => 'gem',
    ensure => 'present',
    require => Package['rubygems'],
  }

  package { 'rack':
    provider => 'gem',
    ensure => '1.1.2',
    require => Package['rubygems'],
  }

  package { 'rdoc':
    provider => 'gem',
    ensure => 'present',
    require => Package['rubygems'],
  }

  package { 'libmysqlclient-dev':
    ensure => 'present',
  }

  package { 'mysql':
    provider => 'gem',
    ensure => 'present',
    require => [Package['libmysqlclient-dev'], Package['rubygems']],
  }

  exec { 'wget_puppet-dashboard':
    command => "/usr/bin/wget -O /var/tmp/${file}.tar.gz http://downloads.puppetlabs.com/dashboard/${file}.tar.gz",
    creates => "/var/tmp/${file}.tar.gz",
  }

  exec { 'install_puppet-dashboard':
    command => "/bin/tar -xzvf /var/tmp/${file}.tar.gz -C /var/tmp",
    creates => "/var/tmp/${file}",
    require => Exec['wget_puppet-dashboard'],
  }

  exec { 'puppet-dashboard_hack':
    command => "/bin/cp -r /var/tmp/${file} /opt/puppet-dashboard",
    creates => '/opt/puppet-dashboard',
    require => Exec['install_puppet-dashboard'],
  }

}
