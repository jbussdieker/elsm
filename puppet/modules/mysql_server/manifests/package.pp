class mysql_server::package inherits mysql_server {

  package { 'mysql-server':
    ensure => 'present',
  }

  package { 'mysql-client':
    ensure => 'present',
  }

}
