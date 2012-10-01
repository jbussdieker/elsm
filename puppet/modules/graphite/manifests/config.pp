class graphite::config inherits graphite {

  file { '/opt/graphite/conf/carbon.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/graphite/carbon.conf',
    require => Class['graphite::package'],
    notify  => Service['carbon-cache'],
  }

  file { '/opt/graphite/conf/storage-schemas.conf':
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/graphite/storage-schemas.conf',
    require => File['/opt/graphite/conf/carbon.conf'],
    notify  => Service['carbon-cache'],
  }

  file { '/opt/graphite/webapp/graphite/local_settings.py':
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/graphite/local_settings.py',
    require => Class['graphite::package'],
    notify  => Service['graphite-web'],
  }

  exec { 'graphite_sync_db':
    cwd  => '/opt/graphite/webapp/graphite',
    command => '/usr/bin/python manage.py syncdb --noinput && touch /var/tmp/graphite_sync_db',
    creates => '/var/tmp/graphite_sync_db',
    require => File['/opt/graphite/webapp/graphite/local_settings.py'],
  }

}
