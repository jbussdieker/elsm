class apt::setup inherits apt {

  exec { 'apt-update':
    command => '/usr/bin/apt-get update && touch /var/tmp/apt_update',
    creates => '/var/tmp/apt_update',
  }

  Exec['apt-update'] -> Package <| |>

}
