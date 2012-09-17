class puppet_dashboard::config inherits puppet_dashboard {

  mysql_server::create_db { "puppet_dashboard":
    db_name => "dashboard_production",
    notify  => Class['puppet_dashboard::service'],
  }

  file { '/opt/puppet-dashboard/config/database.yml':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0600',
    content => template('puppet_dashboard/database.yml.erb'),
    notify  => Class['puppet_dashboard::service'],
    require => Class['puppet_dashboard::package'],
  }

  file { '/opt/puppet-dashboard/config/settings.yml':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0600',
    content => template('puppet_dashboard/settings.yml.erb'),
    notify  => Class['puppet_dashboard::service'],
    require => Class['puppet_dashboard::package'],
  }

  exec { 'db_migrate':
    command => '/usr/local/bin/rake RAILS_ENV=production db:migrate && touch /var/tmp/puppet_dashboard_db_migrate',
    cwd     => '/opt/puppet-dashboard',
    creates => '/var/tmp/puppet_dashboard_db_migrate',
    require => File['/opt/puppet-dashboard/config/database.yml'],
  }

}
