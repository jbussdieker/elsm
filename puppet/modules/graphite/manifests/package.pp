class graphite::package inherits graphite {

  $version = "0.9.9"

  #################
  # WHISPER
  #################
  exec { "whisper_download":
    cwd     => '/var/tmp',
    command => "/usr/bin/wget -O /var/tmp/whisper-${version}.tar.gz http://launchpad.net/graphite/0.9/${version}/+download/whisper-${version}.tar.gz",
    creates => "/var/tmp/whisper-${version}.tar.gz",
  }

  exec { "whisper_extract":
    cwd     => '/var/tmp',
    command => "/bin/tar -xzvf /var/tmp/whisper-${version}.tar.gz -C /var/tmp",
    creates => "/var/tmp/whisper-${version}",
    require => Exec['whisper_download'],
  }

  exec { "whisper_install":
    cwd     => "/var/tmp/whisper-${version}",
    command => "/usr/bin/python setup.py install",
    creates => '/usr/local/lib/python2.7/dist-packages/whisper.py',
    require => Exec['whisper_extract'],
  }

  #################
  # CARBON
  #################
  exec { "carbon_download":
    cwd     => '/var/tmp',
    command => "/usr/bin/wget -O /var/tmp/carbon-${version}.tar.gz http://launchpad.net/graphite/0.9/${version}/+download/carbon-${version}.tar.gz",
    creates => "/var/tmp/carbon-${version}.tar.gz",
  }

  exec { "carbon_extract":
    cwd     => '/var/tmp',
    command => "/bin/tar -xzvf /var/tmp/carbon-${version}.tar.gz -C /var/tmp",
    creates => "/var/tmp/carbon-${version}",
    require => Exec['carbon_download'],
  }

  exec { "carbon_install":
    cwd     => "/var/tmp/carbon-${version}",
    command => "/usr/bin/python setup.py install",
    creates => '/opt/graphite/conf/carbon.conf.example',
    require => [Exec['whisper_install'], Exec['carbon_extract']],
  }

  #################
  # GRAPHITE
  #################
  package { 'python-cairo-dev':
    ensure => 'present',
  }

  package { 'python-django':
    ensure => 'present',
  }

  package { 'python-django-tagging':
    ensure => 'present',
    require => Package['python-django'],
  }

  exec { "graphite_download":
    cwd     => '/var/tmp',
    command => "/usr/bin/wget -O /var/tmp/graphite-web-${version}.tar.gz http://launchpad.net/graphite/0.9/${version}/+download/graphite-web-${version}.tar.gz",
    creates => "/var/tmp/graphite-web-${version}.tar.gz",
    require => Package['python-django'],
  }

  exec { "graphite_extract":
    cwd     => '/var/tmp',
    command => "/bin/tar -xzvf /var/tmp/graphite-web-${version}.tar.gz -C /var/tmp",
    creates => "/var/tmp/graphite-web-${version}",
    require => Exec['graphite_download'],
  }

  exec { "graphite_install":
    cwd     => "/var/tmp/graphite-web-${version}",
    command => "/usr/bin/python setup.py install",
    creates => '/opt/graphite/webapp/',
    require => [Exec['carbon_install'], Exec['graphite_extract']],
  }

}
