define mysql_server::create_db($db_name) {
  exec { "mysql_create_${db_name}":
    unless  => "/usr/bin/mysqlcheck ${db_name}",
    command => "/usr/bin/mysqladmin create ${db_name}",
    require => Package['mysql-server'],
  }
}
