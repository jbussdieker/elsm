class logstash::package inherits logstash {
  $file = "logstash-${u_logstash_version}-monolithic.jar"

  exec { "logstash_download_${file}":
    cwd     => '/tmp',
    command => "/usr/bin/wget -O /tmp/${file} http://semicomplete.com/files/logstash/${file}",
    creates => "/tmp/${file}",
  }

  file { "/opt/${file}":
    ensure  => 'present',
    source  => "/tmp/${file}",
    require => Exec["logstash_download_${file}"],
  }

  package { 'openjdk-7-jre-headless':
    ensure => 'present',
  }

}
