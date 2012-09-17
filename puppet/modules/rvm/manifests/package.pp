class rvm::package inherits rvm {
  $rvm_filename = "rvm-1.14.11-ruby-1.9.2-p180"

  exec { "rvm_download":
    cwd     => '/var/tmp',
    command => "/usr/bin/wget -O /var/tmp/${rvm_filename}.tar https://s3.amazonaws.com/appian/${rvm_filename}.tar",
    creates => "/var/tmp/${rvm_filename}.tar",
  }

  exec { "rvm_extract":
    cwd     => '/usr/local',
    command => "/bin/tar -xzvf /var/tmp/${rvm_filename}.tar -C /usr/local",
    creates => "/usr/local/rvm",
    require => Exec['rvm_download'],
  }

}
